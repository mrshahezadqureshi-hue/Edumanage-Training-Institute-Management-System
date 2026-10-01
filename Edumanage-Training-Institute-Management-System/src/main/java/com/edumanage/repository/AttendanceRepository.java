package com.edumanage.repository;

import com.edumanage.model.Attendance;
import com.edumanage.model.Batch;
import com.edumanage.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;
import java.util.List;

public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    List<Attendance> findByBatchAndAttendanceDate(Batch batch, LocalDate date);
    List<Attendance> findByBatchAndAttendanceDateBetween(Batch batch, LocalDate startDate, LocalDate endDate);
    List<Attendance> findByStudent(User student);
    java.util.Optional<Attendance> findByStudentAndBatchAndAttendanceDate(User student, Batch batch, LocalDate date);
    
    void deleteByStudent(User student);
    void deleteByBatch(Batch batch);
}