Use dfSpnFrm.pkg
Use cRDCDbView.pkg
Use cRDCDbCJGrid.pkg
Use cRDCDbCJGridColumn.pkg
Use cRDCForm.pkg
Use cRDCDbForm.pkg
Use cRDCButton.pkg
Use cRDCDbComboForm.pkg 
Use cRDCDbHeaderGroup.pkg

Use WinPrint\ProjectReportWP.rv
Use cCustomerDataDictionary.dd
Use cProjectDataDictionary.dd
Use cProjectRowsDataDictionary.dd
Use cProjectRowsADataDictionary.dd
Use cInventoryDataDictionary.dd

Use ProjectBilling.vw

ACTIVATE_VIEW Activate_oProjectView FOR oProjectView
Object oProjectView is a cRDCDbView
    Set Location to 2 4
    Set Size to 267 428
    Set Label to "Project Hours"
    Set Border_Style to Border_Thick
    Set Icon to "Project.ico"
    Set pbAutoActivate to True
    
    Object oInvt_DD is a cInventoryDataDictionary
    End_Object

    Object oCustomer_DD is a cCustomerDataDictionary
        Set DDO_Server to oInvt_DD
    End_Object 

    Object oProject_DD is a cProjectDataDictionary
        Set DDO_Server To oCustomer_DD
        // this lets you save a new parent DD from within child DD
        Set Allow_Foreign_New_Save_State to True

        Procedure OnPostFind Integer eMessage Boolean bFound
            Integer iID
            
            Forward Send OnPostFind eMessage bFound
            Get Field_Current_Value Field Project.ID to iID
            Set piProjectID of ghoApplication to iID
        End_Procedure

    End_Object 

    Object oProjectRows_DD is a cProjectRowsDataDictionary
        Set DDO_Server To oProject_DD
        Set Constrain_File To Project.File_Number
    End_Object 

    Set Main_DD To oProject_DD
    Set Server  To oProject_DD

    Object oTop_grp is a cRDCDbHeaderGroup
        Set Size to 114 421
        Set Location to 4 4
        Set Label to "Project Hours"
        Set psNote to "Project Hours Registration" 
        Set psImage to "Project.ico"
        Set peAnchors to anTopLeftRight

        Object oProjectID is a cRDCDbForm
            Entry_Item Project.ID
            Set Size to 13 43
            Set Location to 31 76
            Set Label to "Project ID:"
            Set psToolTip to "Project ID (Auto generated):"
        End_Object 

        Object oProjectName is a cRDCDbForm
            Entry_Item Project.Name
            Set Size to 13 167
            Set Location to 46 76
            Set Label to "Procect Name:"
        End_Object 

        Object oCustomerCustomer_Number is a cRDCDbForm
            Entry_Item Customer.Customer_Number
            Set Size to 13 43
            Set Location to 61 76
            Set Label to "Customer ID:"
        End_Object 

        Object oCustomerName is a cRDCDbForm
            Entry_Item Customer.Name
            Set Size to 13 167
            Set Location to 76 76
            Set Label to "Customer Name:"
        End_Object 

        Object oProjectRows_TotTimeNum is a cRDCDbForm
            Entry_Item (Project.TotTimeSpend)
            Set Server to oProjectRows_DD
            Set Location to 95 305
            Set Size to 13 52
            Set Visible_State to False
            Set peAnchors to anTopRight
            
            Procedure Refresh Integer iNotifyMode
                String sValue               
                Number nPrice nTotTimeSpend nTot
                
                Forward Send Refresh iNotifyMode
                
                Get Field_Current_Value of (Main_DD(Self)) Field Project.TotTimeSpend to nTotTimeSpend
                Get File_Field_Current_Value of (Main_DD(Self)) File_Field Inventory.Unit_Price to nPrice
//                Get ShortTimeString nTotTimeSpend to sValue
                Get DecimalTimeToString nTotTimeSpend to sValue
                Set Value of oTotTimeNum_fm to sValue
                Move (nTotTimeSpend * nPrice) to nTot 
                Get FormatNumber nTot 0 to sValue
                Set Value of oTotalAmount_fm to sValue
            End_Procedure
        
        End_Object                              
        
        Object oCreateOrder_btn is a cRDCButton
            Set Size to 14 94
            Set Location to 46 255
            Set Label to "Create Invoice from Project"
            Set pbAutoEnable to True
        
            Procedure OnClick              
                Integer iProject
                Get Field_Current_Value of (Main_DD(Self)) Field Project.ID to iProject
                Send CreateOrderFromProject of (Main_DD(Self)) iProject
                Send Find of (Main_DD(oInvoiceEntryView(Self))) Last_Record 1
                Send MarkProjectRowsAsInvoiced of (Main_DD(Self)) iProject 
                Send Find of (Main_DD(Self)) LT 1
                Send Find of (Main_DD(Self)) GT 1   
                Send Info_Box "Ready! Invoice created."
            End_Procedure
        
            Function IsEnabled Returns Boolean
                Boolean bHasRecord
                Handle  hoDD
                Get Server to hoDD
                Get HasRecord of hoDD to bHasRecord
                Function_Return bHasRecord
            End_Function

        End_Object
        
        Object oPrintReport_btn is a cRDCButton
            Set Size to 14 94
            Set Location to 76 255
            Set Label to "&Print Report"
        
            Procedure OnClick         
                Integer iProjectID
                Get Field_Current_Value of (Main_DD(Self)) Field Project.ID to iProjectID
                Send StartProjectRowsReport iProjectID 
            End_Procedure
        
            Function IsEnabled Returns Boolean
                Boolean bHasRecord
                Handle  hoDD
                Get Server to hoDD
                Get HasRecord of hoDD to bHasRecord
                Function_Return bHasRecord
            End_Function

        End_Object  
        
        Object oRecalc_btn is a cRDCButton
            Set Size to 14 94
            Set Location to 61 255
            Set Label to "Recalc"
        
            Procedure OnClick
                Send RecalcTotalTime of (Main_DD(Self))    
            End_Procedure
        
            Function IsEnabled Returns Boolean
                Boolean bHasRecord
                Handle  hoDD
                Get Server to hoDD
                Get HasRecord of hoDD to bHasRecord
                Function_Return bHasRecord
            End_Function

        End_Object

    End_Object

    Object oDetailGrid is a cRDCDbCJGrid
        Set Size to 107 421
        Set Location to 128 4
        Set Server to oProjectRows_DD
        Set Ordering to 2
        Set pbHeaderPrompts to True
        Set pbDrawGridForEmptySpace to True
        Set pbAllowAppendRow to True
        Set pbAllowDeleteRow to True
        Set pbAutoAppend to True

        Object oProjectRows_Date is a cRDCDbCJGridColumn
            Entry_Item ProjectRows.WorkDate
            Set piWidth to 90
            Set psCaption to "Work Date"
            Set peHeaderAlignment to xtpAlignmentCenter
            Set peTextAlignment to xtpAlignmentCenter
        End_Object 

        Object oProjectRows_ElapsedTime is a cRDCDbCJGridColumn
            Entry_Item ProjectRows.ElapsedTime
            Set piWidth to 80
            Set psCaption to "Time Spend"
            Set peHeaderAlignment to xtpAlignmentCenter
            Set peTextAlignment to xtpAlignmentCenter 
        End_Object 

        Object oProjectRows_Comment is a cRDCDbCJGridColumn
            Entry_Item ProjectRows.Comment
            Set piWidth to 450
            Set psCaption to "Comment"
            Set pbMultiLine to True
        End_Object

        Object oProjectRows_Invoiced is a cRDCDbCJGridColumn
            Entry_Item ProjectRows.Invoiced
            Set piWidth to 50
            Set psCaption to "Invoiced"
            Set pbCheckbox to True
            Set peHeaderAlignment to xtpAlignmentCenter
        End_Object

    End_Object 

    //-----------------------------------------------------------------------
    // Create custom confirmation messages for save and delete
    // We must create the new functions and assign verify messages
    // to them.
    //-----------------------------------------------------------------------

    Function ConfirmDeleteHeader Returns Boolean
        Boolean bFail
        Get Confirm "Delete Entire Header and all detail?" to bFail
        Function_Return bFail
    End_Function 

    // Only confirm on the saving of new records
    Function ConfirmSaveHeader Returns Boolean
        Boolean bNoSave bHasRecord
        Handle  hoSrvr
        Get Server to hoSrvr
        Get HasRecord of hoSrvr to bHasRecord
        If not bHasRecord Begin
            Get Confirm "Save this NEW header?" to bNoSave
        End
        Function_Return bNoSave
    End_Function 

    // Define alternate confirmation Messages
    Set Verify_Save_MSG       to (RefFunc(ConfirmSaveHeader))
    Set Verify_Delete_MSG     to (RefFunc(ConfirmDeleteHeader))
    // Saves in header should not clear the view
    Set Auto_Clear_Deo_State to False

    Object oCurrent_Month_sf is a SpinForm
        Set Size to 13 27
        Set Location to 249 30
        Set Label_Col_Offset to 2
        Set Label to "Month"
        Set Label_Justification_Mode to JMode_Right
        Set Maximum_Position to 12
        Set Minimum_Position to 1
        Set peAnchors to anBottomLeft

        Procedure End_Construct_Object
            DateTime dtToday
            Integer iMonth
            
            Forward Send End_Construct_Object
            Sysdate dtToday
            Move (DateGetMonth(dtToday)) to iMonth    
            Set Value to iMonth
        End_Procedure    
        
    End_Object

    Object oSum_Current_Month_Hours_btn is a cRDCButton
        Set Size to 14 95
        Set Location to 249 62
        Set Label to "Sum Current Month Hours" 
        Set psToolTip to "Note! This is using the current computer date for calculating first and last date to summerize project costs for."
        Set peAnchors to anBottomLeft
    
        Procedure OnClick
            String sValue               
            Number nPrice nTotAmt nAmt 
            Date dToday dFirstDate dLastDate                                 
            Integer iID iMonth 
            DateTime dtToday
            
            Move 0 to nAmt
            Move 0 to nTotAmt
            Get Value of oCurrent_Month_sf to iMonth  
            If (iMonth < 1 or iMonth > 12) Begin
                Send Info_Box "An invalid month was selected."
                Procedure_Return
            End
            Move (CurrentDateTime()) to dtToday
            Move (DateSetMonth(dtToday, iMonth)) to dtToday
            Move dtToday to dToday
            
            Get FirstDayInMonth dToday to dFirstDate
            Get LastDayInMonth  dToday to dLastDate
            Get Field_Current_Value of (Main_DD(Self)) Field Project.ID to iID
            
            Constraint_Set Self Delete
            Constraint_Set (Self)       
            // We want to look at work time for the previous and current period (different project ID's)
            Constrain ProjectRowsA.ProjectID ge (iID - 1)
            Constrain ProjectRowsA.ProjectID le iID
            Constrain ProjectRowsA.WorkDate  ge dFirstDate
            Constrain ProjectRowsA.WorkDate  le dLastDate
            Constrained_Find First ProjectRowsA by Index.2            
            While (Found)                                  
                Get StringTimeToDecimal ProjectRowsA.ElapsedTime to nAmt
                Move (nAmt + nTotAmt) to nTotAmt
                Constrained_Find Next
            Loop
            Get DecimalTimeToString nTotAmt to sValue
            Set Value of oCurrent_Hours_fm to sValue
        End_Procedure
    
    End_Object

    Object oCurrent_Hours_fm is a cRDCForm
        Set Size to 13 47
        Set Location to 249 161
        Set Label_Justification_Mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_Row_Offset to 1          
        Set peAnchors to anBottomLeft
        Set Enabled_State to False
    End_Object

    Object oInvt_Unit_Price is a cRDCDbForm
        Entry_Item (Inventory.Unit_Price)
        Set Location to 249 255
        Set Size to 13 33
        Set Label to "Unit Price:"
        Set Label_Justification_Mode to JMode_Top
        Set Label_Row_Offset to 1
        Set Label_Col_Offset to 0
        Set peAnchors to anBottomRight
    End_Object

    Object oCustomer_Currency is a cRDCDbForm
        Entry_Item (Customer.Currency)
        Set Location to 249 295
        Set Size to 13 22
        Set Label to "Curr:"
        Set Label_Justification_Mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_Row_Offset to 1
        Set peAnchors to anBottomRight
    End_Object

    Object oTotTimeNum_fm is a cRDCForm
        Set Size to 13 47
        Set Location to 249 321
        Set Label to "Hours Spend:"
        Set Label_Justification_Mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_Row_Offset to 1          
        Set peAnchors to anBottomRight
        Set Enabled_State to False
        Set Form_Datatype to Mask_Time
        Set Form_Mask to "hh:mm"
    End_Object

    Object oTotalAmount_fm is a cRDCForm
        Set Size to 13 52
        Set Location to 249 372
        Set Label to "Total Amount:"
        Set Label_Justification_Mode to JMode_Top
        Set Label_Col_Offset to 0
        Set Label_Row_Offset to 1          
        Set peAnchors to anBottomRight
        Set Enabled_State to False
        Set Form_Datatype to Mask_Numeric_Window
        Set Form_Mask to "### ### ###.##" 
        Set Form_Justification_Mode to Form_DisplayLeft
        Set FontWeight to fw_Bold
    End_Object

    Procedure Activating
        Forward Send Activating
        Send Request_Find of (Main_DD(Self)) LAST_RECORD Project.File_Number 1
    End_Procedure

On_Key Key_Ctrl+Key_P Send KeyAction of oPrintReport_btn
End_Object 
