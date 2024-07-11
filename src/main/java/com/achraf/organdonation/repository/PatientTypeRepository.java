package com.achraf.organdonation.repository;

import com.achraf.organdonation.entity.PatientType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PatientTypeRepository extends JpaRepository<PatientType, Long> {
}