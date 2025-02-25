Use dfClient.pkg
Use DataDict.pkg
Use dfEntry.pkg
Use dfTabDlg.pkg
Use dfCEntry.pkg
Use cDbTextEdit.Pkg
Use cCustomerDataDictionary.DD
Use cDbScrollingContainer.pkg

Deferred_View Activate_oTabbedCustomerView for ;
;
Object oTabbedCustomerView is a dbView
    Set Border_Style to Border_Thick
    Set Label to "Customer Entry View"
    Set Location to 7 23
    Set Size to 142 277
    Set piMaxSize to 175 350
    Set piMinSize to 130 250
    
    Object Customer_DD is a cCustomerDataDictionary
    End_Object
    
    Set Main_DD to Customer_DD
    Set Server to Customer_DD
    
    Object oScrollingContainer1 is a cDbScrollingContainer
        Object oScrollingClientArea1 is a cDbScrollingClientArea
            
            Object oCustomer_Number is a dbForm
                Entry_Item Customer.Customer_Number
                Set Label to "Customer Number:"
                Set Size to 12 42
                Set Location to 5 72
                Set peAnchors to anTopLeft
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
                Set piMaxSize to 13 50
            End_Object
            
            Object oCustomer_Name is a dbForm
                Entry_Item Customer.Name
                Set Label to "Name:"
                Set Size to 12 186
                Set Location to 19 72
                Set peAnchors to anTopLeftRight
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
            End_Object
            
            Object oCustTD is a dbTabDialog
                Set Size to 100 265
                Set Location to 36 7
                Set Rotate_Mode to RM_Rotate
                Set peAnchors to anAll
                Object oAddress_TP is a dbTabPage
                    Set Label to "Address"
                    Set Tab_ToolTip_Value to "Customer contact information"
                    Object oCustomer_Address is a dbForm
                        Entry_Item Customer.Address
                        Set Label to "Street Address:"
                        Set Size to 12 180
                        Set Location to 8 62
                        Set peAnchors to anTopLeftRight
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    
                    Object oCustomer_City is a dbForm
                        Entry_Item Customer.City
                        Set Label to "City/State/Zip:"
                        Set Size to 12 84
                        Set Location to 22 62
                        Set peAnchors to anTopLeftRight
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    
                    Object oCustomer_State is a dbComboForm
                        Entry_Item Customer.State
                        Set Size to 12 32
                        Set Location to 22 152
                        Set peAnchors to anTopRight
                        Set Form_Border to 0
                        Set Code_Display_Mode to cb_code_display_code
                    End_Object
                    
                    Object oCustomer_Zip is a dbForm
                        Entry_Item Customer.Zip
                        Set Size to 12 51
                        Set Location to 22 191
                        Set peAnchors to anTopRight
                    End_Object
                    
                    Object oCustomer_Phone_number is a dbForm
                        Entry_Item Customer.Phone_Number
                        Set Label to "Phone Number:"
                        Set Size to 12 120
                        Set Location to 36 62
                        Set peAnchors to anTopLeft
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    
                    Object oCustomer_Fax_number is a dbForm
                        Entry_Item Customer.Fax_Number
                        Set Label to "Fax Number:"
                        Set Size to 12 120
                        Set Location to 50 62
                        Set peAnchors to anTopLeft
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    
                    Object oCustomer_Email_address is a dbForm
                        Entry_Item Customer.EMail_Address
                        Set Label to "E-Mail Address:"
                        Set Size to 12 180
                        Set Location to 64 62
                        Set peAnchors to anTopLeftRight
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    
                End_Object
                
                Object oBalances_TP is a dbTabPage
                    Set Label to "Balances"
                    Set Tab_ToolTip_Value to "Current account balances"
                    Object oCustomer_Credit_Limit is a dbForm
                        Entry_Item Customer.Credit_limit
                        Set Label to "Credit Limit:"
                        Set Size to 12 48
                        Set Location to 9 72
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    
                    Object oCustomer_Purchases is a dbForm
                        Entry_Item Customer.Purchases
                        Set Label to "Total Purchases:"
                        Set Size to 12 48
                        Set Location to 23 72
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    
                    Object oCustomer_Balance is a dbForm
                        Entry_Item Customer.Balance
                        Set Label to "Balance Due:"
                        Set Size to 12 48
                        Set Location to 37 72
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    
                End_Object
                
                Object oComments_TP is a dbTabPage
                    Set Label to "Comments"
                    Set Tab_ToolTip_Value to "Notes about this customer"
                    Object oCustomer_Comments is a cDbTextEdit
                        Entry_Item Customer.Comments
                        Set Size to 71 242
                        Set Location to 9 9
                        Set peAnchors to anAll
                    End_Object
                    
                End_Object
                
            End_Object
        End_Object
    End_Object
    
Cd_End_Object


