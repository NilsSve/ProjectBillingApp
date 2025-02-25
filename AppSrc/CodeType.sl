Use cRDCDbModalPanel.pkg
Use cRDCDbCJGridPromptList.pkg
Use cRDCDbCJGridColumn.pkg
Use cRDCButton.pkg

Use cCodeTypeDataDictionary.dd

Object CodeType_SL is a cRDCDbModalPanel
    Set Label To "Select a CodeType"
    Set Location To 5 5
    Set Size to 133 236
    Set piMinSize to 133 236

    Object oCodetype_DD is a cCodeTypeDataDictionary
    End_Object

    Set Main_DD To oCodetype_DD
    Set Server To oCodetype_DD

    Object oSelList is a cRDCDbCJGridPromptList
        Set Size to 100 225
        Set Location to 9 7

        Object oCodeType_Type is a cRDCDbCJGridColumn
            Entry_Item CodeType.Type
            Set piWidth to 120
            Set psCaption to "Type"
        End_Object

        Object oCodeType_Description is a cRDCDbCJGridColumn
            Entry_Item CodeType.Description
            Set piWidth to 270
            Set psCaption to "Description"
        End_Object

    End_Object

    Object oOK_bn is a cRDCButton
        Set Label To "&Ok"
        Set Location to 115 75
        Set peAnchors to anBottomRight
        Set Default_State To TRUE

        Procedure OnClick
            Send OK Of oSelList
        End_Procedure
    End_Object

    Object oCancel_bn is a cRDCButton
        Set Label To "&Cancel"
        Set Location to 115 128
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure
    End_Object

    Object oSearch_bn is a cRDCButton
        Set Label To "&Search..."
        Set Location To 115 181
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Search Of oSelList
        End_Procedure
    End_Object

    On_Key Key_Alt+Key_O Send KeyAction Of oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction Of oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction Of oSearch_bn
End_Object
