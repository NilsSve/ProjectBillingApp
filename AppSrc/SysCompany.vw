Use cRDCDbView.pkg
Use cRDCDbCJGrid.pkg
Use cRDCDbCJGridColumn.pkg
Use cRDCForm.pkg
Use cRDCDbForm.pkg
Use cRDCButton.pkg 
Use cRDCDbHeaderGroup.pkg
Use cRDCDbRichEdit.pkg
Use cRDCTextbox.pkg

Use cSysFileDataDictionary.dd
Use Windows.pkg

ACTIVATE_VIEW Activate_oSysCompany FOR oSysCompany
Object oSysCompany is a cRDCDbView
    Set Location to 4 3
    Set Size to 257 430
    Set Label to "Company"
    Set Verify_Save_Msg to msg_none
    Set Icon to "Company.ico"
    Set pbAutoActivate to True 

    Object oSysFile_DD is a cSysfileDataDictionary
    End_Object 

    Set Main_DD To oSysFile_DD
    Set Server  To oSysFile_DD

    Object oCompany_grp is a cRDCDbHeaderGroup
        Set Location to 4 4
        Set Size to 114 423
        Set psImage to "Company.ico"
        Set Label to "Your Company" 
        Set psNote to "Details about your company"
        Set peAnchors to anTopLeftRight

        Object oSysFileCompany is a cRDCDbForm
            Entry_Item SysFile.Company
            Set Size to 13 126
            Set Location to 29 81
            Set Label to "Company:"
        End_Object
    
        Object oSysFileContact is a cRDCDbForm
            Entry_Item SysFile.Contact
            Set Size to 13 126
            Set Location to 44 81
            Set Label to "Contact:"
        End_Object
    
        Object oSysFileAddress is a cRDCDbForm
            Entry_Item SysFile.Address
            Set Size to 13 126
            Set Location to 59 81
            Set Label to "Address:"
        End_Object
    
        Object oSysFileZip is a cRDCDbForm
            Entry_Item SysFile.Zip
            Set Size to 13 126
            Set Location to 29 259
            Set Label to "Zip:"
        End_Object
    
        Object oSysFileCity is a cRDCDbForm
            Entry_Item SysFile.City
            Set Size to 13 126
            Set Location to 44 259
            Set Label to "City:"
        End_Object
    
        Object oSysFileCountry is a cRDCDbForm
            Entry_Item SysFile.Country
            Set Size to 13 126
            Set Location to 59 259
            Set Label to "Country:"
        End_Object

        Object oSysFilePhone_Number is a cRDCDbForm
            Entry_Item SysFile.Phone_Number
            Set Size to 13 126
            Set Location to 75 81
            Set Label to "Phone Number:"
        End_Object

        Object oSysFileE_Mail is a cRDCDbForm
            Entry_Item SysFile.E_Mail
            Set Size to 13 126
            Set Location to 91 81
            Set Label to "E Mail:"
        End_Object

        Object oSysFileWeb_Site is a cRDCDbForm
            Entry_Item SysFile.Web_Site
            Set Size to 13 126
            Set Location to 91 259
            Set Label to "Web Site:"
        End_Object
    
    End_Object
    
        Object oSysFileOrg_Number is a cRDCDbForm
            Entry_Item SysFile.Org_Number
            Set Size to 13 126
            Set Location to 131 85
            Set Label to "Org Number:"
        End_Object
    
        Object oSysFileVat_Number is a cRDCDbForm
            Entry_Item SysFile.Vat_Number
            Set Size to 13 126
            Set Location to 146 85
            Set Label to "Vat Number:"
        End_Object
    
        Object oSysFileBank is a cRDCDbForm
            Entry_Item SysFile.Bank
            Set Size to 13 126
            Set Location to 131 289
            Set Label to "Bank:"
        End_Object
    
        Object oSysFileBank_BIC is a cRDCDbForm
            Entry_Item SysFile.BIC
            Set Size to 13 126
            Set Location to 146 289
            Set Label to "(SWIFT) BIC Number:"
            Set psToolTip to "BIC = Bank Identifier Code"
        End_Object
    
    //    Object oBIC_tb is a cRDCTextbox
    //        Set Size to 10 64
    //        Set Location to 49 388
    //        Set Label to "(Bank Identifier Code)"
    //    End_Object
    
        Object oSysFileBank_Account is a cRDCDbForm
            Entry_Item SysFile.Bank_Account
            Set Size to 13 126
            Set Location to 161 289
            Set Label to "Bank Account:"
        End_Object
    
        Object oSysFileBank_IBAN is a cRDCDbForm
            Entry_Item SysFile.IBAN
            Set Size to 13 126
            Set Location to 176 289
            Set Label to "IBAN Number:" 
            Set psToolTip to "IBAN = International Bank Account Number"
        End_Object
    
    //    Object oIBAN_tb is a cRDCTextbox
    //        Set Size to 13 119
    //        Set Location to 77 386
    //        Set Label to "(International Bank Account Number)"
    //    End_Object
    
        Object oDbRichEdit1 is a cRDCDbRichEdit
            Entry_Item SysFile.Terms
            Set Size to 50 332
            Set Location to 202 85
            Set Label to "Comment:"
            Set peAnchors to anNone
            Set Label_Justification_Mode to JMode_Right
            Set Label_Row_Offset to 0
            Set Label_Col_Offset to 2
        End_Object

End_Object
