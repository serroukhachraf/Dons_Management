package com.achraf.organdonation.repository;

import com.achraf.organdonation.entity.PatientStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PatientStatusRepository extends JpaRepository<PatientStatus, Long> {
}
