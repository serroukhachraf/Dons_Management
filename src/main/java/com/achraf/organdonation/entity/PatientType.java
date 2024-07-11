package com.achraf.organdonation.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "Patient_Type")
public class PatientType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer ptt_id;

    @Column(name = "ptt_name", nullable = false)
    private String ptt_name;

    @Column(name = "ptt_desc")
    private String ptt_desc;


}