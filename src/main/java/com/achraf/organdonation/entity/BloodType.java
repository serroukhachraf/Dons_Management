package com.achraf.organdonation.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "Blood_Type")
public class BloodType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer bt_id;

    @Column(name = "bt_blood", nullable = false)
    private String bt_blood;

    @Column(name = "bt_rhesus", nullable = false)
    private String bt_rhesus;

    @Column(name = "bt_phenotype", nullable = false)
    private String bt_phenotype;

    @Column(name = "bt_kell", nullable = false)
    private String bt_kell;

}
