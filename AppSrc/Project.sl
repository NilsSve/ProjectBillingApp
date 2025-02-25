Use cRDCDbModalPanel.pkg
Use cRDCDbCJGridPromptList.pkg
Use cRDCDbCJGridColumn.pkg
Use cRDCButton.pkg

Use cCustomerDataDictionary.dd
Use cProjectDataDictionary.dd

Object Project_sl is a cRDCDbModalPanel
    Set Location to 5 5
    Set Size to 134 254
    Set Label To "Project Lookup List"
    Set Minimize_Icon to False
    Set Icon to "Project.ico"
    
    Object oCustomer_DD is a cCustomerDataDictionary
    End_Object 

    Object oProject_DD is a cProjectDataDictionary
        Set DDO_Server To oCustomer_DD
    End_Object 

    Set Main_DD To oProject_DD
    Set Server  To oProject_DD

    Object oSelList is a cRDCDbCJGridPromptList
        Set Size to 105 244
        Set Location to 5 5
        Set Ordering to 1
        Set pbAutoServer to True

        Object oProject_ID is a cRDCDbCJGridColumn
            Entry_Item Project.ID
            Set piWidth to 83
            Set psCaption to "ID"
        End_Object 

        Object oProject_Name is a cRDCDbCJGridColumn
            Entry_Item Project.Name
            Set piWidth to 324
            Set psCaption to "Name"
        End_Object 

    End_Object 

    Object oOk_bn is a cRDCButton
        Set Label to "&Ok"
        Set Location to 115 91
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send OK of oSelList
        End_Procedure

    End_Object 

    Object oCancel_bn is a cRDCButton
        Set Label to "&Cancel"
        Set Location to 115 145
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure

    End_Object 

    Object oSearch_bn is a cRDCButton
        Set Label to "&Search..."
        Set Location to 115 199
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Search of oSelList
        End_Procedure

    End_Object 

    On_Key Key_Alt+Key_O Send KeyAction of oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction of oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction of oSearch_bn
End_Object
