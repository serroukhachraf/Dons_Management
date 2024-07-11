package com.achraf.organdonation.repository;

import com.achraf.organdonation.entity.BloodType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BloodTypeRepository extends JpaRepository<BloodType, Long> {
}