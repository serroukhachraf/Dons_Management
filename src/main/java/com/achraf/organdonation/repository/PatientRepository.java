package com.achraf.organdonation.repository;

import com.achraf.organdonation.entity.Patient;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PatientRepository extends JpaRepository<Patient, Long> {
}
