package com.achraf.organdonation.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Data
@Table(name = "Patient")
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer pt_id;

    @ManyToOne
    @JoinColumn(name = "pt_ptt_id", nullable = false)
    private PatientType patientType;

    @ManyToOne
    @JoinColumn(name = "pt_bt_id", nullable = false)
    private BloodType bloodType;

    @ManyToOne
    @JoinColumn(name = "pt_ps_id", nullable = false)
    private PatientStatus patientStatus;

    @Column(name = "pt_name", nullable = false)
    private String name;

    @Column(name = "pt_firstname", nullable = false)
    private String firstname;

    @Column(name = "pt_address")
    private String address;

    @Column(name = "pt_city")
    private String city;

    @Column(name = "pt_country")
    private String country;

    @Column(name = "pt_zip_code")
    private String zipCode;

    @Column(name = "pt_weight", nullable = false)
    private Integer weight;

    @Column(name = "pt_height", nullable = false)
    private Integer height;

    @Column(name = "pt_weight_unit")
    private String weightUnit;

    @Column(name = "pt_height_unit")
    private String heightUnit;

    @Column(name = "pt_birthdate", nullable = false)
    private Date birthdate;

    @Column(name = "pt_birth_country", nullable = false)
    private String birthCountry;

    @Column(name = "pt_birth_city", nullable = false)
    private String birthCity;

}