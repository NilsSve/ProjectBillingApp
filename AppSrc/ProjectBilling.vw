Use dfSpnEnt.pkg
Use cRDCDbView.pkg
Use cRDCDbCJGrid.pkg
Use cRDCDbCJGridColumn.pkg
Use cRDCDbHeaderGroup.pkg
Use cCJGridColumnRowIndicator.pkg
Use cRDCForm.pkg
Use cRDCDbForm.pkg
Use cRDCDbComboForm.pkg
Use cRDCButton.pkg
Use for_all.pkg
Use vWin32fh.pkg

Use MonthCalendarPrompt.dg
Use WinPrint\InvoiceReportWP.rv

Use cInventoryDataDictionary.dd
Use cCustomerDataDictionary.dd
Use cInvoiceHeaderDataDictionary.dd
Use cInvoiceDetailDataDictionary.dd

Activate_View Activate_oInvoiceEntryView for oInvoiceEntryView
Object oInvoiceEntryView is a cRDCDbView
    Set Maximize_Icon to True
    Set Label to "Project Billing"
    Set Location to 2 4
    Set Size to 266 453
    Set Icon to "Money.ico"
    Set pbAutoActivate to True
    Set Auto_Clear_DEO_State to False
    
    Object oInventory_DD is a cInventoryDataDictionary
    End_Object   

    Object oCustomer_DD is a cCustomerDataDictionary 
        Set Field_Option Field Customer.Name     DD_NOENTER to True
        Set Field_Option Field Customer.Currency DD_NOENTER to True
        Set Field_Option Field Customer.Country  DD_NOENTER to True
    End_Object   

    Object oInvoiceHeader_DD is a cInvoiceHeaderDataDictionary
        Set DDO_Server to oCustomer_DD
        // this lets you save a new InvoiceHeader from within InvoiceDetail.
        Set Allow_Foreign_New_Save_State to True

        Procedure OnPostFind Integer eMessage Boolean bFound
            Integer iID
            
            Forward Send OnPostFind eMessage bFound
            Get Field_Current_Value Field InvoiceHeader.Invoice_Number to iID
            Set piInvoiceID of ghoApplication to iID
        End_Procedure

    End_Object   

    Object oInvoiceDetail_DD is a cInvoiceDetailDataDictionary
        Set DDO_Server to oInvoiceHeader_DD
        Set DDO_Server to oInventory_DD
        Set Constrain_File to InvoiceHeader.File_Number
    End_Object

    Set Main_DD to oInvoiceHeader_DD
    Set Server to oInvoiceHeader_DD

    Object oTop_grp is a cRDCDbHeaderGroup
        Set Size to 114 445
        Set Location to 4 4
        Set Label to "Invoicing/Billing"
        Set psNote to "Create/Edit Project Invoices"
        Set psImage to "Money.ico"
        Set peAnchors to anTopLeftRight

        Object oInvoHea_Invoice_Number is a cRDCDbForm
            Entry_Item InvoiceHeader.Invoice_Number 
            Set Label to "Invoice Number:"
            Set Size to 13 42
            Set Location to 33 73
            Set Prompt_Button_Mode to PB_PromptOn
            Set Prompt_Object to oInvoHea_sl            
        End_Object

        Object oInvoHea_Customer_Number is a cRDCDbForm
            Entry_Item Customer.Customer_Number
            Set Label to "Customer:"
            Set Size to 13 42
            Set Location to 33 162
            Set peAnchors to anNone
            Set Prompt_Button_Mode to PB_PromptOn
            Set Prompt_Object to Customer_sl

            // If Invoice record exists, disallow entry in customer window.
            Procedure Refresh Integer iMode
                Handle  hoSrvr
                Boolean bCrnt
                Get Server to hoSrvr                // get the data_set
                Get HasRecord of hoSrvr to bCrnt    // has record in data_set
                // Set displayonly to true if iCrnt is non-zero
                Set Enabled_State to (not(bCrnt))
                Forward Send Refresh iMode          // do normal refrsh
                // don't leave us sitting on a displayonly window
                If (bCrnt and Focus(Self)=Self) Send Next
            End_Procedure
            
        End_Object

        Object oCustomer_Currency is a cRDCDbForm
            Entry_Item Customer.Currency
            Set Location to 33 260
            Set Size to 13 67
            Set Label to "Currency:"
            Set Prompt_Button_Mode to pb_PromptOff
            Set Enabled_State to False
        End_Object

        Object oCustomer_Name is a cRDCDbForm
            Entry_Item Customer.Name
            Set Label to "Customer Name:"
            Set Size to 13 131
            Set Location to 48 73
            Set Prompt_Button_Mode to pb_PromptOff
            Set Enabled_State to False
        End_Object    

        Object oCustomer_Country is a cRDCDbForm
            Entry_Item Customer.Country
            Set Location to 48 260
            Set Size to 13 67
            Set Label to "Country;"
            Set peAnchors to anNone
        End_Object

        Object oCustomer_Address is a cRDCDbForm
            Entry_Item Customer.Address
            Set Label to "Street Address:"
            Set Size to 13 131
            Set Location to 63 73
            Set peAnchors to anNone
        End_Object    

        Object oCustomer_Zip is a cRDCDbForm
            Entry_Item Customer.Zip
            Set Size to 13 60
            Set Location to 79 73
            Set Label to "Zip/City/Country:"
        End_Object

        Object oCustomer_City is a cRDCDbForm
            Entry_Item Customer.City
            Set Size to 13 53
            Set Location to 79 135
        End_Object

        Object oInvoHea_Invoice_Date is a cRDCDbForm
            Entry_Item InvoiceHeader.Invoice_Date
            Set Label to "Invoice Date:"
            Set Size to 13 67
            Set Location to 63 260
            Set peAnchors to anNone
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
            Set Prompt_Object to oMonthCalendarPrompt
            Set Prompt_Button_Mode to PB_PromptOn 
            Procedure Prompt
                Send Popup of oMonthCalendarPrompt
            End_Procedure
        End_Object

        Object oInvoHea_Ordered_By is a cRDCDbForm
            Entry_Item InvoiceHeader.Ordered_By
            Set Label to "Ordered By:"
            Set Size to 13 67
            Set Location to 79 260
        End_Object

        Object oInvoHea_Terms is a DbComboForm
            Entry_Item InvoiceHeader.Terms
            Set Label to "Terms:"
            Set Size to 13 114
            Set Location to 95 73
            Set Form_Border to 0
            Set Entry_State to False
        End_Object

        Object oInvoHea_Payed_Date is a cRDCDbForm
            Entry_Item InvoiceHeader.Payed_Date
            Set Location to 94 260
            Set Size to 13 67
            Set Label to "Payed Date:"
            Set Prompt_Object to oMonthCalendarPrompt
            Set Prompt_Button_Mode to PB_PromptOn 
            Procedure Prompt
                Send Popup of oMonthCalendarPrompt
            End_Procedure
        End_Object

        Object oPrint_Btn is a cRDCButton
            Set Size to 13 79
            Set Label to "Print Invoice"
            Set Location to 94 337
            Set peAnchors to anNone
            Set Skip_State to True
            Set pbAutoEnable to True
    
            Procedure OnClick   
                Integer iInvoice
                Get Field_Current_Value of oInvoiceHeader_DD Field InvoiceHeader.Invoice_Number to iInvoice
                Send ShowInvoiceReport iInvoice
            End_Procedure  

            Function IsEnabled Returns Boolean
                Boolean bHasRecord
                Handle  hoDD
                Get Server to hoDD
                Get HasRecord of hoDD to bHasRecord
                Function_Return bHasRecord
            End_Function

        End_Object    

        Object oOpenFolder_Btn is a cRDCButton
            Set Size to 13 79
            Set Label to "Open Output Folder"
            Set Location to 63 337
            Set peAnchors to anNone
            Set Skip_State to True
            Set pbAutoEnable to True
    
            Procedure OnClick   
                String sPath sUser
                Get Network_User_Name to sUser // DFAbout function.
                Move ("C:\Users\" + String(sUser) + "\OneDrive\Documents\") to sPath
                Send vShellExecute "open" "Explorer.exe" sPath ""
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
            Set Size to 13 79
            Set Location to 79 337
            Set Label to "Recalc"
            Set peAnchors to anNone
            Set Skip_State to True
            Set pbAutoEnable to True
        
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

    Object oInvoDtl_Grid is a cRDCDbCJGrid
        Set Server to oInvoiceDetail_DD
        Set Ordering to 1
        Set Size to 107 443
        Set Location to 128 4
        Set pbDrawGridForEmptySpace to True
        Set pbHeaderTogglesDirection to False
        Set pbHeaderPrompts to True
        Set pbHeaderReorders to False
        Set pbAllowAppendRow to True
        Set pbAutoAppend to True
        Set pbAllowDeleteRow to True
        Set pbAllowInsertRow to True
        Set pbSelectTextOnEdit to True
        Set piLayoutBuild to 5

//        Procedure Request_Save
//            Forward Send Request_Save
//        End_Procedure
            
        Object oMark is a cCJGridColumnRowIndicator
            Set piWidth to 19
        End_Object

        Object oInvt_Item_ID is a cRDCDbCJGridColumn
            Entry_Item Inventory.Item_ID
            Set piWidth to 54
            Set psCaption to "Item ID"
            Set psImage to "ActionPrompt.ico"
            Set Prompt_Button_Mode to PB_PromptOn
            Set pbAllowRemove to False  
            Set peHeaderAlignment to xtpAlignmentCenter
            Set peTextAlignment to xtpAlignmentCenter
        End_Object

        Object oInvt_Description is a cRDCDbCJGridColumn
            Entry_Item Inventory.Description
            Set piWidth to 86
            Set psCaption to "Description"
        End_Object

        Object oInvt_Comment is a cRDCDbCJGridColumn
            Entry_Item InvoiceDetail.Comment
            Set piWidth to 424
            Set psCaption to "Comment"
            Set pbMultiLine to True
        End_Object

        Object oInvoDtl_Qty_Ordered is a cRDCDbCJGridColumn
            Entry_Item InvoiceDetail.Qty_Ordered
            Set piWidth to 46
            Set psCaption to "Qty"
            Set peHeaderAlignment to xtpAlignmentCenter
            Set peTextAlignment to xtpAlignmentCenter
        End_Object

        Object oInvoDtl_Price is a cRDCDbCJGridColumn
            Entry_Item InvoiceDetail.Price
            Set piWidth to 45
            Set psCaption to "Price"
            Set peHeaderAlignment to xtpAlignmentCenter
            Set peTextAlignment to xtpAlignmentCenter
        End_Object

        Object oInvoDtl_Extended_Price is a cRDCDbCJGridColumn
            Entry_Item InvoiceDetail.Extended_Price
            Set piWidth to 65
            Set psCaption to "Total"
            Set peHeaderAlignment to xtpAlignmentCenter
            Set peTextAlignment to xtpAlignmentCenter
        End_Object

        // We need to refresh the grid after a line has been deleted,
        // so that renumberd lines display properly.
        Procedure Request_Delete
            Forward Send Request_Delete
            Send RefreshDataFromDD 0 
        End_Procedure
        
    End_Object

    Object oCustomer_Currency is a cRDCDbForm
        Entry_Item Customer.Currency
        Set Location to 249 269
        Set Size to 13 22
        Set Label to "Curr:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Top
        Set Prompt_Button_Mode to pb_PromptOff
        Set Enabled_State to False
        Set peAnchors to anBottomRight
    End_Object

    Object oInvoice_Total_Qty_Ordered is a cRDCDbForm
        Entry_Item InvoiceHeader.Invoice_Total_Qty_Ordered
        Set Label to "Quantity Total:"
        Set Size to 13 47
        Set Location to 249 295
        Set peAnchors to anBottomRight
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Top
        Set Label_Row_Offset to 1
        Set Enabled_State to False  
    End_Object

    Object oInvoHea_Invoice_Total is a cRDCDbForm
        Entry_Item InvoiceHeader.Invoice_Total
        Set Label to "Hours Spend:"
        Set Size to 13 51
        Set Location to 249 347
        Set peAnchors to anBottomRight
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Top
        Set Label_Row_Offset to 1
        Set Form_Datatype to Mask_Numeric_Window
        Set Form_Mask to "### ### ###.##" 
        Set Enabled_State to False  
    End_Object

    Object oInvoHea_Invoice_TotalInclVAT is a cRDCDbForm
        // Entry_Item InvoiceHeader.Invoice_Total
        Set Label to "Total incl. VAT:"
        Set Size to 13 43
        Set Location to 249 402
        Set peAnchors to anBottomRight
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Top
        Set Label_Row_Offset to 1
        Set Form_Datatype to Mask_Numeric_Window
        Set Form_Mask to "### ### ###.##" 
        Set Enabled_State to False  

        Procedure Refresh Integer NotifyMode
            String sValue
            Move (Customer.VAT /100 * InvoiceHeader.Invoice_Total + InvoiceHeader.Invoice_Total) to sValue
            Get FormatCurrency sValue 0  to sValue  
            Move (Replaces("á", sValue, " ")) to sValue
            Move (Replace("kr", sValue, ""))  to sValue  
            Set Value to sValue
        End_Procedure
    End_Object

    // Create custom confirmation messages for save and delete
    // We must create the new functions and assign verify messages
    // to them.
    Function Confirm_Delete_Invoice Returns Integer
        Integer iRetVal
        Get Confirm "Delete Entire Invoice?" to iRetVal
        Function_Return iRetVal
    End_Function
    
    // Only confirm on the saving of new records
    Function Confirm_Save_Invoice Returns Integer
        Integer iNoSave iSrvr
        Boolean bOld
        Get Server to iSrvr
        Get HasRecord of iSrvr to bOld
        If (not(bOld)) Begin
            Get Confirm "Save this NEW Invoice header?" to iNoSave
        End
        Function_Return iNoSave
    End_Function
    
    // Define alternate confirmation Messages
    Set Verify_Save_MSG       to (RefFunc(Confirm_Save_Invoice))
    Set Verify_Delete_MSG     to (RefFunc(Confirm_Delete_Invoice))
    Set Auto_Clear_DEO_State  to False // don't clear Header on save
    
    // Change: Table entry checking - attempt to save header record
    //         before entering a table (this is called by table. Return
    //         a non-zero if the save failed (i.e., don't enter table)
//    Function Save_Header Returns Integer
//        Boolean bHasRec bChanged
//        Handle hoSrvr
//    
//        Get Server to hoSrvr                 // The Header DDO.
//        Get HasRecord of hoSrvr to bHasRec   // Do we have a record?
//        Get Should_Save to bChanged          // Are there any current changes?
//    
//        // If there is no record and no changes we have an error.
//        If ( not(bHasRec) and not(bChanged) ) Begin  // no rec
//            Send UserError DfErr_Operator 'You must First Create & Save Main Invoice Header'
//            Function_Return 1
//        End
//    
//        // Attempt to Save the current Record
//        // request_save_no_clear does a save without clearing.
//        Send Request_Save_No_Clear
//    
//        // The save succeeded if there are now no changes, and we
//        // have a saved record. Should_save tells us if we've got changes.
//        // We must check the data-sets hasRecord property to see if
//        // we have a record. If it is not, we had no save.
//        Get Should_Save to bChanged  // is a save still needed
//        Get HasRecord of hoSrvr to bHasRec // current record of the DD
//        // if no record or changes still exist, return an error code of 1
//        If ( not(bHasRec) or (bChanged)) ;
//            Function_Return 1
//    End_Function
    
    Procedure Activating
        Forward Send Activating
        Send Request_Find of (Main_DD(Self)) LAST_RECORD InvoiceHeader.File_Number 1
    End_Procedure

    On_Key Key_Ctrl+Key_P Send KeyAction of oPrint_Btn
End_Object
