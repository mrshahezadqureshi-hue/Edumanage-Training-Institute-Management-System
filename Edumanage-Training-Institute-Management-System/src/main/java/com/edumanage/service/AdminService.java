package com.edumanage.service;

import com.edumanage.model.Batch;
import com.edumanage.model.User;
import com.edumanage.model.Task;
import com.edumanage.model.Attendance;
import com.edumanage.repository.AttendanceRepository;
import com.edumanage.repository.BatchRepository;
import com.edumanage.repository.SubmissionRepository;
import com.edumanage.repository.TaskRepository;
import com.edumanage.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.time.LocalDate;
import java.util.Map;
import java.util.ArrayList;
import java.util.LinkedHashMap;

import javax.transaction.Transactional;

@Service
public class AdminService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BatchRepository batchRepository;
    
    @Autowired(required = false)
    private SubmissionRepository submissionRepository;

    @Autowired(required = false)
    private AttendanceRepository attendanceRepository; // ✅ Required to clean attendance records

    @Autowired(required = false)
    private TaskRepository taskRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;
    // TRAINER CRUD
    public User createTrainer(String fullName, String email, String phone,
                              String username, String rawPassword) {

        if (userRepository.existsByUsername(username)) {
            throw new RuntimeException("Username already exists : " + username);
        }

        User trainer = new User();
        trainer.setFullName(fullName);
        trainer.setEmail(email);
        trainer.setPhone(phone);
        trainer.setUsername(username);
        trainer.setPassword(passwordEncoder.encode(rawPassword));
        trainer.setRole(User.Role.TRAINER);
        trainer.setActive(true);

        return userRepository.save(trainer);
    }

    public List<User> listTrainers() {
        return userRepository.findByRole(User.Role.TRAINER);
    }

    public User findTrainerById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Trainer not found : " + id));
    }

    public User updateTrainer(User trainer) {

        User existingTrainer = findTrainerById(trainer.getId());

        existingTrainer.setFullName(trainer.getFullName());
        existingTrainer.setEmail(trainer.getEmail());
        existingTrainer.setPhone(trainer.getPhone());
        existingTrainer.setUsername(trainer.getUsername());

        if (trainer.getPassword() != null &&
                !trainer.getPassword().trim().isEmpty()) {

            existingTrainer.setPassword(
                    passwordEncoder.encode(trainer.getPassword()));
        }

        existingTrainer.setActive(trainer.isActive());

        return userRepository.save(existingTrainer);
    }

    @Transactional
    public void deleteTrainer(Long id) {

        User trainer = findTrainerById(id);

        // 1. Unlink trainer from batches
        List<Batch> batches = batchRepository.findAll();
        for (Batch batch : batches) {
            if (batch.getTrainer() != null && batch.getTrainer().getId().equals(id)) {
                batch.setTrainer(null);
                batchRepository.save(batch);
            }
        }

        // 2. Remove tasks created by trainer. Delete their submissions first
        // because submissions have a non-null foreign key to task.
        if (taskRepository != null) {
            List<Task> tasks = taskRepository.findAll();
            for (Task task : tasks) {
                if (task.getTrainer() != null && task.getTrainer().getId().equals(id)) {
                    if (submissionRepository != null) {
                        submissionRepository.deleteAll(submissionRepository.findByTask(task));
                    }
                    taskRepository.delete(task);
                }
            }
        }

        // 3. Remove trainer attendance records before deleting the user.
        if (attendanceRepository != null) {
            attendanceRepository.deleteByStudent(trainer);
        }

        // 4. Flush the delete so the username is immediately released for reuse.
        userRepository.delete(trainer);
        userRepository.flush();
    }
    // STUDENT CRUD
    public List<User> listStudents() {
        return userRepository.findByRole(User.Role.STUDENT);
    }

    public User findStudentById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Student not found : " + id));
    }

    public User updateStudent(User student) {

        User existingStudent = findStudentById(student.getId());

        existingStudent.setFullName(student.getFullName());
        existingStudent.setEmail(student.getEmail());
        existingStudent.setPhone(student.getPhone());
        existingStudent.setUsername(student.getUsername());

        if (student.getPassword() != null &&
                !student.getPassword().trim().isEmpty()) {

            existingStudent.setPassword(
                    passwordEncoder.encode(student.getPassword()));
        }

        existingStudent.setActive(student.isActive());

        return userRepository.save(existingStudent);
    }

    // ✅ FIXED: Unlink Batches, Attendance, and Submissions before deleting Student
    @Transactional
    public void deleteStudent(Long id) {

        User student = findStudentById(id);

        // 1. Remove student from all batches
        List<Batch> batches = batchRepository.findByStudents_Id(id);
        for (Batch batch : batches) {
            batch.getStudents().remove(student);
        }
        batchRepository.saveAll(batches);

        // 2. Remove attendance records for this student if repository exists
        if (attendanceRepository != null) {
            attendanceRepository.deleteByStudent(student);
        }

        // 3. Remove submission records for this student if repository exists
        if (submissionRepository != null) {
            submissionRepository.deleteByStudent(student);
        }

        // 4. Safely delete student user
        userRepository.delete(student);
    }
    // BATCH MANAGEMENT
    public Batch createBatch(Batch batch) {
        return batchRepository.save(batch);
    }

    public List<Batch> listBatches() {
        return batchRepository.findAll();
    }

    public Batch findBatchById(Long id) {
        return batchRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Batch not found : " + id));
    }

    public Batch updateBatch(Long id, String batchName, String courseName,
                             java.time.LocalDate startDate, java.time.LocalDate endDate, Long trainerId) {
        Batch batch = findBatchById(id);
        batch.setBatchName(batchName);
        batch.setCourseName(courseName);
        batch.setStartDate(startDate);
        batch.setEndDate(endDate);
        batch.setTrainer(trainerId != null ? findTrainerById(trainerId) : null);
        return batchRepository.save(batch);
    }

    @Transactional
    public void deleteBatch(Long id) {
        Batch batch = findBatchById(id);

        if (taskRepository != null) {
            List<Task> tasks = taskRepository.findByBatch(batch);
            if (submissionRepository != null) {
                for (Task task : tasks) {
                    submissionRepository.deleteAll(submissionRepository.findByTask(task));
                }
            }
            taskRepository.deleteAll(tasks);
        }

        if (attendanceRepository != null) {
            attendanceRepository.deleteByBatch(batch);
        }

        batch.getStudents().clear();
        batchRepository.save(batch);
        batchRepository.delete(batch);
    }


    // ATTENDANCE MANAGEMENT
    @Transactional
    public void markAttendance(Batch batch, LocalDate date, Map<Long, String> statusMap) {
        for (User student : batch.getStudents()) {
            String statusStr = statusMap.get(student.getId());
            if (statusStr == null || statusStr.trim().isEmpty()) {
                continue;
            }

            Attendance attendance = attendanceRepository
                    .findByStudentAndBatchAndAttendanceDate(student, batch, date)
                    .orElseGet(Attendance::new);

            attendance.setStudent(student);
            attendance.setBatch(batch);
            attendance.setAttendanceDate(date);
            attendance.setStatus(Attendance.Status.valueOf(statusStr));
            attendanceRepository.save(attendance);
        }
    }

    public List<Attendance> findAttendanceByBatchAndDate(Batch batch, LocalDate date) {
        return attendanceRepository.findByBatchAndAttendanceDate(batch, date);
    }

    public List<Map<String, Object>> getAttendanceMonthlyReport(Batch batch, LocalDate startDate, LocalDate endDate) {
        List<Attendance> records = attendanceRepository.findByBatchAndAttendanceDateBetween(batch, startDate, endDate);
        Map<Long, Map<String, Object>> report = new LinkedHashMap<>();

        for (User student : batch.getStudents()) {
            Map<String, Object> row = new LinkedHashMap<>();
            row.put("student", student);
            row.put("present", 0);
            row.put("absent", 0);
            row.put("late", 0);
            row.put("total", 0);
            report.put(student.getId(), row);
        }

        for (Attendance a : records) {
            if (a.getStudent() == null || a.getStatus() == null || !report.containsKey(a.getStudent().getId())) continue;
            Map<String, Object> row = report.get(a.getStudent().getId());
            int total = (Integer) row.get("total");
            row.put("total", total + 1);
            String key = a.getStatus().name().toLowerCase();
            row.put(key, (Integer) row.get(key) + 1);
        }

        List<Map<String, Object>> result = new ArrayList<>();
        for (Map<String, Object> row : report.values()) {
            int total = (Integer) row.get("total");
            int present = (Integer) row.get("present");
            int late = (Integer) row.get("late");
            double percentage = total == 0 ? 0.0 : ((present + (late * 0.5)) * 100.0 / total);
            row.put("percentage", Math.round(percentage * 10.0) / 10.0);
            result.add(row);
        }
        return result;
    }

    public Batch assignTrainer(Long batchId, Long trainerId) {

        Batch batch = findBatchById(batchId);

        User trainer = findTrainerById(trainerId);

        batch.setTrainer(trainer);

        return batchRepository.save(batch);
    }

    public Batch assignStudents(Long batchId, List<Long> studentIds) {

        Batch batch = findBatchById(batchId);

        Set<User> students =
                new HashSet<>(userRepository.findAllById(studentIds));

        batch.getStudents().clear();
        batch.getStudents().addAll(students);

        return batchRepository.save(batch);
    }

}