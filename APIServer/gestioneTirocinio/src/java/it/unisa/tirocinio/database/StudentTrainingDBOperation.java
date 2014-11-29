/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.tirocinio.database;

import it.unisa.integrazione.database.DBConnection;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author carlosborges
 */
public class StudentTrainingDBOperation {
    private  Connection aConnection;
    
    /**
     *
     */
    public StudentTrainingDBOperation(){
        
    }
    
    /**
     *
     * @param studentSerialNumber
     * @param idStudentInformation
     * @throws ClassNotFoundException
     * @throws SQLException
     * @throws IOException
     */
    public void startTraining(String studentSerialNumber, int idStudentInformation) throws ClassNotFoundException, SQLException, IOException{
        aConnection = DBConnection.connect();
        CallableStatement pcInsert = aConnection.prepareCall("{call getStudentInformation(?)}");
        pcInsert.setString("studentSerialNumber", studentSerialNumber);
        pcInsert.setInt("FK_IDstundetInformation", idStudentInformation);
        pcInsert.execute();
        pcInsert.close();
        aConnection.close();
    }
        /**
     * This method call the db store procedure storeUploadFile to save the 
     * path into db
     * @param cvPath
     * @param ATPath
     * @param StudentSerialNumber
     * @throws java.sql.SQLException
     * @throws java.lang.ClassNotFoundException
     * @throws java.io.IOException
     */
    public void uploadFilesPathToDB(String cvPath, String ATPath, String StudentSerialNumber) throws SQLException, ClassNotFoundException, IOException{
        aConnection = DBConnection.connect();
        CallableStatement pcUpload = aConnection.prepareCall("{call storeUploadFile(?, ?,?)}");//Prepare a call to the stored procedure storeUploadFile
        pcUpload.setString("CVPath", cvPath);
        pcUpload.setString("ATPath", ATPath);
        pcUpload.setString("serialNumber", StudentSerialNumber);
        pcUpload.execute();
        pcUpload.close();
        aConnection.close();
        
    }
  
    /**
     *This method call the db store procedure getStudentTrainingStatus to get Student training status and description
     * @param pkStudentStatus
     * @return trainingStatus
     * @throws ClassNotFoundException
     * @throws SQLException
     * @throws IOException
     */
    public String[] getStudentTrainingStatus( int pkStudentStatus ) throws ClassNotFoundException, SQLException, IOException{
        String[] trainingStatus = new String[2];
        aConnection = DBConnection.connect();
        CallableStatement pcTrainingStatus = aConnection.prepareCall("{call getStudentTrainingStatus(?)}");
        pcTrainingStatus.setInt("pkStudentStatus", pkStudentStatus);
        pcTrainingStatus.execute();
        pcTrainingStatus.close();
        trainingStatus[0] = String.valueOf(pcTrainingStatus.getInt(1));
        trainingStatus[1] = pcTrainingStatus.getString(2);
        aConnection.close();
        return trainingStatus;
    }
    
}
