package com.achraf.organdonation.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "Patient_Status")
public class PatientStatus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer ps_id;

    @Column(name = "ps_name", nullable = false)
    private String ps_name;

    @Column(name = "ps_desc")
    private String ps_desc;

}