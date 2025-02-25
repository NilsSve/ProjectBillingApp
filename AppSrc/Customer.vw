Use cDbTextEdit.Pkg
Use Dftabdlg.pkg
Use cRDCDbView.pkg
Use cRDCDbCJGrid.pkg
Use cRDCDbCJGridColumn.pkg
Use cRDCForm.pkg
Use cRDCDbForm.pkg
Use cRDCButton.pkg
Use cRDCDbComboForm.pkg
Use cRDCDbHeaderGroup.pkg

Use cInventoryDataDictionary.dd
Use cCustomerDataDictionary.dd

Activate_View Activate_oCustomerView for oCustomerView
Object oCustomerView is a cRDCDbView
    Set Label to "Customers"
    Set Location to 7 23
    Set Size to 305 322
    Set Auto_Clear_DEO_State to False
    Set Icon to "CustomerSingle.ico"
    Set Verify_Save_msg to (RefFunc(No_Confirmation))
    Set pbAutoActivate to True

    Object oInvt_DD is a cInventoryDataDictionary
    End_Object

    Object Customer_DD is a cCustomerDataDictionary
        Set DDO_Server to oInvt_DD
    End_Object

    Set Main_DD to Customer_DD
    Set Server to Customer_DD

    Object oCustomer_grp is a cRDCDbHeaderGroup
        Set Location to 4 4
        Set Size to 114 315
        Set Label to "Customer"
        Set psNote to "Customer Details"
        Set psImage to "CustomerSingle.ico"
        Set peAnchors to anTopLeftRight

        Object oCustomer_Number is a cRDCDbForm
            Entry_Item Customer.Customer_Number
            Set Label to "Customer Number:"
            Set Size to 13 42
            Set Location to 47 76
            Set peAnchors to anTopLeft
        End_Object
    
        Object oCustomer_Name is a cRDCDbForm
            Entry_Item Customer.Name
            Set Label to "Name:"
            Set Size to 13 212
            Set Location to 62 76
            Set peAnchors to anNone
        End_Object
    
        Object oPrintReport_btn is a cRDCButton
            Set Size to 13 90
            Set Location to 47 197
            Set Label to "&Print Customer List"
        
            Procedure OnClick         
                Send Activate_o1CustomerListWP
            End_Procedure
        
        End_Object  

    End_Object
    
        Object oCustTD is a dbTabDialog
            Set Size to 173 284
            Set Location to 128 32
            Set Rotate_Mode to RM_Rotate
            Set peAnchors to anTopLeftRight
            
            Object oAddress_TP is a dbTabPage
                Set Label to "Address"
                Object oCustomer_Address is a cRDCDbForm
                    Entry_Item Customer.Address
                    Set Label to "Street Address:"
                    Set Size to 13 214
                    Set Location to 8 62
                    Set peAnchors to anNone
                End_Object
    
                Object oCustomer_City is a cRDCDbForm
                    Entry_Item Customer.City
                    Set Label to "City/State/Zip:"
                    Set Size to 13 120
                    Set Location to 24 62
                    Set peAnchors to anNone
                End_Object
    
                Object oCustomer_State is a DbComboForm
                    Entry_Item Customer.State
                    Set Size to 13 32
                    Set Location to 24 186
                    Set Form_Border to 0
                    Set peAnchors to anNone
                    Set Entry_State to False
                    Set Code_Display_Mode to CB_Code_Display_Code
                End_Object
    
                Object oCustomer_Zip is a cRDCDbForm
                    Entry_Item Customer.Zip
                    Set Size to 13 51
                    Set Location to 24 225
                    Set peAnchors to anNone
                End_Object
    
                Object oCustomer_Country is a cRDCDbForm
                    Entry_Item Customer.Country
                    Set Location to 39 62
                    Set Size to 13 120
                    Set Label to "Country:"
                End_Object
    
                Object oCustomer_Phone_number is a cRDCDbForm
                    Entry_Item Customer.Phone_Number
                    Set Label to "Phone Number:"
                    Set Size to 13 120
                    Set Location to 54 62
                    Set peAnchors to anTopLeft
                End_Object
    
                Object oCustomer_Fax_number is a cRDCDbForm
                    Entry_Item Customer.Fax_Number
                    Set Label to "Fax Number:"
                    Set Size to 13 120
                    Set Location to 69 62
                    Set peAnchors to anTopLeft
                End_Object
    
                Object oCustomer_Email_address is a cRDCDbForm
                    Entry_Item Customer.EMail_Address
                    Set Label to "E-Mail Address:"
                    Set Size to 13 214
                    Set Location to 84 62
                    Set peAnchors to anNone
                End_Object
    
                Object oCustomer_VAT_Number is a cRDCDbForm
                    Entry_Item Customer.VAT_Number
                    Set Location to 99 62
                    Set Size to 13 120
                    Set Label to "VAT Number:"
                End_Object
    
                Object oCustomer_VAT is a cRDCDbForm
                    Entry_Item Customer.VAT
                    Set Location to 99 218
                    Set Size to 13 25
                    Set Label to "VAT (%):"
                End_Object
    
                Object oInvt_Item_ID is a cRDCDbForm
                    Entry_Item Inventory.Item_ID
                    Set Location to 124 62
                    Set Size to 13 65
                    Set Label to "Default Item"
                End_Object
    
                Object oInvt_Description is a cRDCDbForm
                    Entry_Item Inventory.Description
                    Set Location to 124 133
                    Set Size to 13 140
                    Set peAnchors to anNone
                End_Object
    
                Object oInvt_Unit_Price is a cRDCDbForm
                    Entry_Item Inventory.Unit_Price
                    Set Location to 140 134
                    Set Size to 13 21
                    Set Label to "Unit Price:"
                End_Object
    
                Object oCustomer_Currency is a dbComboForm
                    Entry_Item Customer.Currency
                    Set Location to 140 62
                    Set Size to 13 31
                    Set Label to "Currency:"
                    Set Entry_State to False
                    Set Code_Display_Mode to CB_Code_Display_Code
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to JMode_Right
                End_Object
    
            End_Object
    
            Object oBalances_TP is a dbTabPage
                Set Label to "Balances"
                
                Object oCustomer_Credit_Limit is a cRDCDbForm
                    Entry_Item Customer.Credit_limit
                    Set Label to "Credit Limit:"
                    Set Size to 13 48
                    Set Location to 9 72
                End_Object
    
                Object oCustomer_Purchases is a cRDCDbForm
                    Entry_Item Customer.Purchases
                    Set Label to "Total Purchases:"
                    Set Size to 13 48
                    Set Location to 24 72
                End_Object
    
                Object oCustomer_Balance is a cRDCDbForm
                    Entry_Item Customer.Balance
                    Set Label to "Balance Due:"
                    Set Size to 13 48
                    Set Location to 39 72
                End_Object
    
            End_Object
    
            Object oComments_TP is a dbTabPage
                Set Label to "Comments"
                
               Object oCustomer_Comments is a cDbTextEdit
                    Entry_Item Customer.Comments
                    Set Size to 105 276
                    Set Location to 9 9
                    Set peAnchors to anAll
                End_Object
    
            End_Object
    
        End_Object    

    Procedure Activating
        Forward Send Activating
        Send Request_Find of (Main_DD(Self)) LAST_RECORD Customer.File_Number 1
    End_Procedure

    On_Key Key_Ctrl+Key_S Send Request_Save
End_Object
