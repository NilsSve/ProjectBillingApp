Use cRDCDbView.pkg
Use cRDCForm.pkg
Use cRDCButton.pkg
Use Windows.pkg

Open SysFile
Open Inventory
Open Customer
Open InvoiceHeader
Open InvoiceDetail
Open Project
Open ProjectRows

Class cTableRDCForm is a cRDCForm
    Procedure Construct_Object
        Forward Send Construct_Object

        Property Integer piTable -1

        Set Size to 13 50
        Set Enabled_State to False 
        Set Value to "Table Records:"
    End_Procedure
    
    Procedure End_Construct_Object
        Integer iRecords
        String sTableName
        
        Forward Send End_Construct_Object
        If (piTable(Self) <> -1) Begin
            Get_Attribute DF_FILE_LOGICAL_NAME of (piTable(Self)) to sTableName
            Set Label to (sTableName * String("Records:"))
            Get_Attribute DF_FILE_RECORDS_USED of (piTable(Self)) to iRecords
            Set Value to iRecords
        End
        Set Enabled_State to False
        Set Entry_State to False
        Set Skip_State to True 
    End_Procedure  
    
    Procedure Refresh
        Integer iRecords
        If (piTable(Self) <> -1) Begin
            Get_Attribute DF_FILE_RECORDS_USED of (piTable(Self)) to iRecords
            Set Value to iRecords
        End
    End_Procedure

End_Class

Class cTableButton is a cRDCButton
    Procedure Construct_Object
        Forward Send Construct_Object

        Property Integer piTable -1 
        Property Handle phoFormObject -1
        
        Set Size to 13 100
        Set Value to "Reset Table Records:"
    End_Procedure
    
    Procedure End_Construct_Object
        String sTableName
        
        Forward Send End_Construct_Object
        If (piTable(Self) <> -1) Begin
            Get_Attribute DF_FILE_LOGICAL_NAME of (piTable(Self)) to sTableName
            Set Label to ("Reset" * String(sTableName) * String("Table"))
            Set psToolTip to ("Removes all records from the" * String(sTableName) * "table")
        End
    End_Procedure 

    Procedure OnClick
        Integer iTable iRetval
        String sTableName sInfo 
        Handle hoFormObject
        
        Get piTable to iTable
        If (iTable = -1) Begin
            Send Info_Box "piTable property not set for this button object! Cannot continue."
            Procedure_Return
        End
        
        Get_Attribute DF_FILE_LOGICAL_NAME of (piTable(Self)) to sTableName
        Get YesNo_Box ("Are you sure you want to remove ALL records for the:" * String(sTableName) + "?") to iRetval
        If (iRetval <> MBR_Yes) Begin
            Procedure_Return    
        End
        Move False to Err  
        Close DF_ALL DF_TEMPORARY
        Open iTable DF_EXCLUSIVE
        If (Err = False) Begin
            ZeroFile iTable
            Get phoFormObject to hoFormObject
            If (hoFormObject <> -1) Begin
                Send Refresh of hoFormObject
            End
        End
        If (Err = True) Begin
            Move ("An error occured while trying to remove all records from the table:" * String(sTableName) * "Procedure failed.") to sInfo
        End
        Else Begin
            Move ("Success! All records for the table:" * String(sTableName) * "was successfully removed.") to sInfo
        End
        Send Info_Box sInfo
    End_Procedure 

End_Class

Deferred_View Activate_oZeroFile_vw for ;
Object oZeroFile_vw is a cRDCDbView
    Set Size to 163 427
    Set Location to 77 321
    Set Label to "Reset Data Tables"
    Set Icon to "ActionDelete1.ico"
    
    Object oInventory_fm is a cTableRDCForm 
        Set piTable to Inventory.File_Number
        Set Location to 20 98
    End_Object

    Object oInventory_btn is a cTableButton
        Set piTable to Inventory.File_Number 
        Set phoFormObject to (oInventory_fm(Self))
        Set Location to 20 152
    End_Object

    Object oCustomer_fm is a cTableRDCForm 
        Set piTable to Customer.File_Number
        Set Location to 36 98
    End_Object
    
    Object oCustomer_btn is a cTableButton
        Set piTable to Customer.File_Number
        Set phoFormObject to (oCustomer_fm(Self))
        Set Location to 36 152
    End_Object

    Object oInvoiceHeader_fm is a cTableRDCForm 
        Set piTable to InvoiceHeader.File_Number
        Set Location to 52 98
    End_Object
    
    Object oInvoiceHeader_btn is a cTableButton
        Set piTable to InvoiceHeader.File_Number
        Set phoFormObject to (oInvoiceHeader_fm(Self))
        Set Location to 52 152
    End_Object

    Object oInvoiceDetail_fm is a cTableRDCForm 
        Set piTable to InvoiceDetail.File_Number
        Set Location to 69 98
    End_Object
    
    Object oInvoiceDetail_btn is a cTableButton
        Set piTable to InvoiceDetail.File_Number
        Set phoFormObject to (oInvoiceDetail_fm(Self))
        Set Location to 69 152
    End_Object

    Object oProject_fm is a cTableRDCForm 
        Set piTable to Project.File_Number
        Set Location to 86 98
    End_Object
    
    Object oProject_btn is a cTableButton
        Set piTable to Project.File_Number
        Set phoFormObject to (oProject_fm(Self))
        Set Location to 86 152
    End_Object

    Object oProjectRows_fm is a cTableRDCForm 
        Set piTable to ProjectRows.File_Number
        Set Location to 103 98
    End_Object
    
    Object oProjectRows_btn is a cTableButton
        Set piTable to ProjectRows.File_Number
        Set phoFormObject to (oProjectRows_fm(Self))
        Set Location to 103 152
    End_Object

    Object oWarning_tb is a TextBox
        Set Auto_Size_State to False
        Set Size to 36 146
        Set Location to 20 262
        Set Label to "Warning! These actions cannot be undone! Once you have deleted data for a table, the data is gone. These should only be used to remove DEMO data."
        Set Justification_Mode to JMode_Left
    End_Object

    Object oInfo_tb is a TextBox
        Set Auto_Size_State to False
        Set Size to 36 146
        Set Location to 123 103
        Set Label to "Note: Info about your company is kept in the SysFile table and consists of one record only. It cannot be deleted. Instead edit the data on the Company view."
        Set Justification_Mode to JMode_Left
    End_Object

Cd_End_Object
