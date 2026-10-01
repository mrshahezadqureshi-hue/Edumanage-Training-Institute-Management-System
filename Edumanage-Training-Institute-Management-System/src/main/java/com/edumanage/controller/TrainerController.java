package com.edumanage.controller;

import com.edumanage.model.*;
import com.edumanage.repository.UserRepository;
import com.edumanage.service.TrainerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.awt.PageAttributes.MediaType;
import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.core.io.FileSystemResource;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;



@Controller
@RequestMapping("/trainer")
public class TrainerController {

    @Autowired
    private TrainerService trainerService;

    @Autowired
    private UserRepository userRepository;

    private User currentTrainer(Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) {
            throw new RuntimeException("Authentication session expired");
        }

        return userRepository.findByUsername(auth.getName())
                .orElseThrow(() -> new RuntimeException("Trainer record not found"));
    }

    // ---------- 1. Trainer Dashboard ----------

    @GetMapping("/dashboard")
    public String dashboard(Authentication auth, Model model) {

        User trainer = currentTrainer(auth);

        List<Batch> batches =
                trainerService.findBatchesByTrainer(trainer);

        model.addAttribute("trainer", trainer);
        model.addAttribute("batches", batches);
        model.addAttribute("batchCount", batches.size());
        model.addAttribute(
                "studentCount",
                trainerService.findAllStudentsForTrainer(trainer).size()
        );
        model.addAttribute(
                "taskCount",
                trainerService.findAllTasksForTrainer(trainer).size()
        );
        model.addAttribute(
                "pendingReviewCount",
                trainerService.countPendingSubmissions(trainer)
        );

        return "trainer/dashboard";
    }

    // ---------- 2. Dedicated Batches Page ----------

    @GetMapping("/batches")
    public String viewBatches(Authentication auth, Model model) {

        User trainer = currentTrainer(auth);

        List<Batch> batches =
                trainerService.findBatchesByTrainer(trainer);

        model.addAttribute("trainer", trainer);
        model.addAttribute("batches", batches);

        return "trainer/batches";
    }

    // ---------- 3. Students Management ----------

    @GetMapping("/students")
    public String viewAllStudents(Authentication auth, Model model) {

        User trainer = currentTrainer(auth);

        model.addAttribute(
                "students",
                trainerService.findAllStudentsForTrainer(trainer)
        );

        model.addAttribute(
                "batches",
                trainerService.findBatchesByTrainer(trainer)
        );

        return "trainer/students";
    }

    @GetMapping("/batch/{id}/students")
    public String viewStudents(@PathVariable Long id,
                                Authentication auth,
                                Model model) {

        User trainer = currentTrainer(auth);

        Batch batch =
                trainerService.findBatchForTrainer(id, trainer);

        model.addAttribute("batch", batch);
        model.addAttribute("students", batch.getStudents());

        return "trainer/batch-students";
    }

    // ---------- 4. Attendance Management ----------

    @GetMapping("/attendance")
    public String defaultAttendance(Authentication auth, Model model) {

        User trainer = currentTrainer(auth);

        List<Batch> batches =
                trainerService.findBatchesByTrainer(trainer);

        if (!batches.isEmpty()) {
            return "redirect:/trainer/batch/"
                    + batches.get(0).getId()
                    + "/attendance";
        }

        return "redirect:/trainer/dashboard";
    }

    @GetMapping("/batch/{id}/attendance")
    public String attendanceForm(@PathVariable Long id,
                                 @RequestParam(required = false) String date,
                                 Authentication auth,
                                 Model model) {

        User trainer = currentTrainer(auth);

        Batch batch =
                trainerService.findBatchForTrainer(id, trainer);

        LocalDate selectedDate =
                (date == null || date.trim().isEmpty())
                        ? LocalDate.now()
                        : LocalDate.parse(date);

        Map<Long, String> statusMap = new HashMap<>();

        for (Attendance attendance :
                trainerService.findAttendanceByBatchAndDate(
                        batch,
                        selectedDate)) {

            statusMap.put(
                    attendance.getStudent().getId(),
                    attendance.getStatus().name()
            );
        }

        model.addAttribute("batch", batch);
        model.addAttribute("today", selectedDate);
        model.addAttribute("statusMap", statusMap);

        return "trainer/attendance";
    }

    @PostMapping("/batch/{id}/attendance")
    public String markAttendance(@PathVariable Long id,
                                 @RequestParam String date,
                                 @RequestParam Map<String, String> allParams,
                                 Authentication auth,
                                 RedirectAttributes redirectAttributes) {

        User trainer = currentTrainer(auth);

        Batch batch =
                trainerService.findBatchForTrainer(id, trainer);

        Map<Long, String> statusMap = new HashMap<>();

        for (Map.Entry<String, String> entry :
                allParams.entrySet()) {

            if (entry.getKey().startsWith("status_")) {

                Long studentId = Long.parseLong(
                        entry.getKey()
                                .substring("status_".length())
                );

                statusMap.put(
                        studentId,
                        entry.getValue()
                );
            }
        }

        trainerService.markAttendance(
                batch,
                LocalDate.parse(date),
                statusMap
        );

        redirectAttributes.addFlashAttribute(
                "message",
                "Attendance saved successfully for " + date
        );

        return "redirect:/trainer/batch/"
                + id
                + "/attendance?date="
                + date;
    }

    // ---------- 5. Tasks & Submissions ----------

    @GetMapping("/tasks")
    public String viewAllTasks(Authentication auth, Model model) {

        User trainer = currentTrainer(auth);

        model.addAttribute(
                "tasks",
                trainerService.findAllTasksForTrainer(trainer)
        );

        return "trainer/tasks";
    }

    @GetMapping("/submissions")
    public String viewAllSubmissions(Authentication auth,
                                     Model model) {

        return "redirect:/trainer/tasks";
    }

    @GetMapping("/batch/{id}/tasks/new")
    public String newTaskForm(@PathVariable Long id,
                              Authentication auth,
                              Model model) {

        User trainer = currentTrainer(auth);

        model.addAttribute(
                "batch",
                trainerService.findBatchForTrainer(id, trainer)
        );

        model.addAttribute("task", new Task());

        return "trainer/task-form";
    }

    @PostMapping("/batch/{id}/tasks")
    public String assignTask(@PathVariable Long id,
                             @ModelAttribute Task task,
                             Authentication auth,
                             RedirectAttributes redirectAttributes) {

        User trainer = currentTrainer(auth);

        Batch batch =
                trainerService.findBatchForTrainer(id, trainer);

        task.setBatch(batch);
        task.setTrainer(trainer);

        trainerService.assignTask(task);

        redirectAttributes.addFlashAttribute(
                "message",
                "Task created and assigned successfully!"
        );

        return "redirect:/trainer/tasks";
    }

    @GetMapping("/tasks/{taskId}/submissions")
    public String viewSubmissions(@PathVariable Long taskId,
                                  Authentication auth,
                                  Model model) {

        User trainer = currentTrainer(auth);

        Task task =
                trainerService.findTaskForTrainer(taskId, trainer);

        model.addAttribute("task", task);

        model.addAttribute(
                "submissions",
                trainerService.findSubmissionsByTask(task)
        );

        return "trainer/submissions";
    }
    
    @GetMapping("/submissions/{id}/download")
    public void downloadSubmission(
            @PathVariable Long id,
            Authentication auth,
            HttpServletResponse response) throws IOException {

        User trainer = currentTrainer(auth);

        Submission submission =
                trainerService.findSubmissionForTrainer(id, trainer);

        if (submission.getFilePath() == null ||
                submission.getFileName() == null) {
            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "File not found");
            return;
        }

        java.io.File file =
                new java.io.File(submission.getFilePath());

        if (!file.exists() || !file.isFile()) {
            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "File not found");
            return;
        }

        response.setContentType("application/octet-stream");

        response.setHeader(
                "Content-Disposition",
                "attachment; filename=\"" +
                submission.getFileName().replace("\"", "") +
                "\"");

        response.setContentLengthLong(file.length());

        java.io.FileInputStream input =
                new java.io.FileInputStream(file);

        java.io.OutputStream output =
                response.getOutputStream();

        byte[] buffer = new byte[8192];
        int bytesRead;

        while ((bytesRead = input.read(buffer)) != -1) {
            output.write(buffer, 0, bytesRead);
        }

        input.close();
        output.flush();
    }
    
    

    @PostMapping("/submissions/{id}/feedback")
    public String giveFeedback(@PathVariable Long id,
                                @RequestParam Integer marks,
                                @RequestParam String feedback,
                                Authentication auth,
                                RedirectAttributes redirectAttributes) {

        User trainer = currentTrainer(auth);

        Submission submission =
                trainerService.giveFeedback(
                        id,
                        marks,
                        feedback,
                        trainer
                );

        redirectAttributes.addFlashAttribute(
                "message",
                "Feedback and marks submitted successfully!"
        );

        return "redirect:/trainer/tasks/"
                + submission.getTask().getId()
                + "/submissions";
    }
    
    

    // ---------- 6. Trainer Profile ----------

    @GetMapping("/profile")
    public String showTrainerProfile(Authentication auth,
                                     Model model) {

        User trainer = currentTrainer(auth);

        model.addAttribute("trainer", trainer);

        return "trainer/profile";
    }

    @PostMapping("/profile/update")
    public String updateTrainerProfile(
            @ModelAttribute User formTrainer,
            Authentication auth,
            RedirectAttributes redirectAttributes) {

        User trainer = currentTrainer(auth);

        trainer.setFullName(formTrainer.getFullName());
        trainer.setEmail(formTrainer.getEmail());
        trainer.setPhone(formTrainer.getPhone());

        userRepository.save(trainer);

        redirectAttributes.addFlashAttribute(
                "message",
                "Profile details updated successfully!"
        );

        return "redirect:/trainer/profile";
    }
}