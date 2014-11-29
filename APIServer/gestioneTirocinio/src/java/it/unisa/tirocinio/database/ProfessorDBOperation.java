/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.tirocinio.database;

import it.unisa.integrazione.database.DBConnection;
import it.unisa.integrazione.manager.concrete.ConcreteDepartment;
import it.unisa.integrazione.manager.concrete.ConcreteProfessor;
import java.io.IOException;
import static java.lang.System.out;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Valentino
 */
public class ProfessorDBOperation {
    private Connection aConnection;

    public ProfessorDBOperation() throws ClassNotFoundException, SQLException, IOException{
        
    }
    
    public ConcreteProfessor getInformationForProfessorByPrimaryKey(int primaryKey) throws SQLException, ClassNotFoundException, IOException{
        aConnection = DBConnection.connect();
        CallableStatement pcSelect = aConnection.prepareCall("{call getProfessorInformationByPrimaryKey(?)}");        
        ConcreteProfessor aProf = new ConcreteProfessor();
        pcSelect.setInt("pkProfessor",primaryKey);
        ResultSet rs = pcSelect.executeQuery();
        while (rs.next()) {
            aProf.setIdProfessor(rs.getInt(1));
            aProf.setPosition(rs.getString(2));
            aProf.setOfficePhoneNum(rs.getString(3));
            aProf.setOfficeHours(rs.getString(4));
            aProf.setOfficeEmail(rs.getString(5));
            aProf.setFKAccount(rs.getInt(6));
            aProf.setFKFisicPerson(rs.getInt(7));
            aProf.setFKDepartment(rs.getInt(8));
        }
        
        pcSelect.close();
        aConnection.close();
        return aProf;
    }
    
    public ConcreteProfessor getInformationForProfessorByFK_Account(int FKAccount) throws SQLException, ClassNotFoundException, IOException{
        aConnection = DBConnection.connect();
        CallableStatement pcSelect = aConnection.prepareCall("{call getProfessorInformationByFK_Account(?)}");        
        ConcreteProfessor aProf = new ConcreteProfessor();
        pcSelect.setInt("pkFKAccount",FKAccount);
        ResultSet rs = pcSelect.executeQuery();
        while (rs.next()) {
            aProf.setIdProfessor(rs.getInt(1));
            aProf.setPosition(rs.getString(2));
            aProf.setOfficePhoneNum(rs.getString(3));
            aProf.setOfficeHours(rs.getString(4));
            aProf.setOfficeEmail(rs.getString(5));
            aProf.setFKAccount(rs.getInt(6));
            aProf.setFKFisicPerson(rs.getInt(7));
            aProf.setFKDepartment(rs.getInt(8));
        }
        
        pcSelect.close();
        aConnection.close();
        return aProf;
    }
    
    public boolean setOfferTrainingByProfessorByPrimaryKey(String description, int primaryKeyProf) throws SQLException, ClassNotFoundException, IOException{
        ConcreteProfessor aProf = getInformationForProfessorByPrimaryKey(primaryKeyProf);
        ConcreteDepartment aDepa = new ConcreteDepartment();
        aConnection = DBConnection.connect();
        CallableStatement pcInsertTraining = aConnection.prepareCall("{call insertOuterTraining(?)}");        
        CallableStatement pcSelectDepa = aConnection.prepareCall("{call getDepartment(?)}");      
        pcSelectDepa.setInt("pkDepartment",aProf.getFKDepartment());
        ResultSet rs = pcSelectDepa.executeQuery();
        while (rs.next()) {
            aDepa.setIdDepartment(rs.getInt(1));
        }
        pcInsertTraining.setString("trainingDescription", description);
        pcInsertTraining.setInt("FK_Department", aDepa.getIdDepartment());
        pcInsertTraining.setString("pkOrganization",null);
        pcInsertTraining.setInt("professor", aProf.getIdProfessor());
        int result = pcInsertTraining.executeUpdate();
        pcInsertTraining.close();
        pcSelectDepa.close();
        aConnection.close();
        if (result == 1 )
            return true;
        return false;
    }
    
    public boolean setOfferTrainingByProfessorByFK_Account(String description, int FKAccount) throws SQLException, ClassNotFoundException, IOException{
        ConcreteProfessor aProf = getInformationForProfessorByFK_Account(FKAccount);
        aConnection = DBConnection.connect();
        CallableStatement pcInsertTraining = aConnection.prepareCall("{call insertOuterTraining(?)}");        
        pcInsertTraining.setString("trainingDescription", description);
        pcInsertTraining.setString("FK_Organization",null);
        pcInsertTraining.setInt("FK_Professor", aProf.getIdProfessor());
        pcInsertTraining.setInt("FK_Department", aProf.getFKDepartment());
        int result = pcInsertTraining.executeUpdate();
        pcInsertTraining.close();
        aConnection.close();
        if (result == 1 )
            return true;
        return false;
    }
    
}
