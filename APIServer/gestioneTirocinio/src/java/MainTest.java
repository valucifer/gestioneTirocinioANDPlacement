
import it.unisa.integrazione.manager.concrete.*;
import it.unisa.tirocinio.database.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author carlosborges
 */
public class MainTest {

    public static void main(String[] args) {
        StudentAttendanceDetails details;

        try {
            details = new StudentAttendanceDetails();
            ArrayList<StudentTrainingInformation> dataToReturn = details.getStudentDetails();
            for (StudentTrainingInformation aStundetInfo : dataToReturn) {
                System.out.print(aStundetInfo.getStudent().getPrimaryKey());
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MainTest.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MainTest.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(MainTest.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
