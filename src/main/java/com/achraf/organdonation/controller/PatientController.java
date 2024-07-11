package com.achraf.organdonation.controller;

import com.achraf.organdonation.exception.ResourceNotFoundException;
import com.achraf.organdonation.entity.Patient;
import com.achraf.organdonation.entity.PatientType;
import com.achraf.organdonation.entity.BloodType;
import com.achraf.organdonation.entity.PatientStatus;
import com.achraf.organdonation.repository.PatientRepository;
import com.achraf.organdonation.repository.PatientTypeRepository;
import com.achraf.organdonation.repository.BloodTypeRepository;
import com.achraf.organdonation.repository.PatientStatusRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/patients")
public class PatientController {

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private PatientTypeRepository patientTypeRepository;

    @Autowired
    private BloodTypeRepository bloodTypeRepository;

    @Autowired
    private PatientStatusRepository patientStatusRepository;

    // Gestion des Patients
    @GetMapping
    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    @PostMapping
    public Patient createPatient(@RequestBody Patient patient) {
        return patientRepository.save(patient);
    }

    @GetMapping("/{id}")
    public Patient getPatientById(@PathVariable Long id) {
        return patientRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Patient not found"));
    }

    @PutMapping("/{id}")
    public Patient updatePatient(@PathVariable Long id, @RequestBody Patient patientDetails) {
        Patient patient = patientRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Patient not found"));

        patient.setName(patientDetails.getName());
        patient.setFirstname(patientDetails.getFirstname());
        patient.setAddress(patientDetails.getAddress());
        patient.setCity(patientDetails.getCity());
        patient.setCountry(patientDetails.getCountry());
        patient.setZipCode(patientDetails.getZipCode());
        patient.setWeight(patientDetails.getWeight());
        patient.setHeight(patientDetails.getHeight());
        patient.setWeightUnit(patientDetails.getWeightUnit());
        patient.setHeightUnit(patientDetails.getHeightUnit());
        patient.setBirthdate(patientDetails.getBirthdate());
        patient.setBirthCountry(patientDetails.getBirthCountry());
        patient.setBirthCity(patientDetails.getBirthCity());
        patient.setPatientType(patientDetails.getPatientType());
        patient.setBloodType(patientDetails.getBloodType());
        patient.setPatientStatus(patientDetails.getPatientStatus());

        return patientRepository.save(patient);
    }

    @DeleteMapping("/{id}")
    public void deletePatient(@PathVariable Long id) {
        Patient patient = patientRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Patient not found"));
        patientRepository.delete(patient);
    }

    // Gestion des Types de Patients
    @GetMapping("/types")
    public List<PatientType> getAllPatientTypes() {
        return patientTypeRepository.findAll();
    }

    @PostMapping("/types")
    public PatientType createPatientType(@RequestBody PatientType patientType) {
        return patientTypeRepository.save(patientType);
    }

    // Gestion des Types de Sang
    @GetMapping("/bloodtypes")
    public List<BloodType> getAllBloodTypes() {
        return bloodTypeRepository.findAll();
    }

    @PostMapping("/bloodtypes")
    public BloodType createBloodType(@RequestBody BloodType bloodType) {
        return bloodTypeRepository.save(bloodType);
    }

    // Gestion des Statuts des Patients
    @GetMapping("/statuses")
    public List<PatientStatus> getAllPatientStatuses() {
        return patientStatusRepository.findAll();
    }

    @PostMapping("/statuses")
    public PatientStatus createPatientStatus(@RequestBody PatientStatus patientStatus) {
        return patientStatusRepository.save(patientStatus);
    }
}
