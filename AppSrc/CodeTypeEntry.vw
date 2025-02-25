Use cDbTextEdit.pkg
Use cRDCDbView.pkg
Use cRDCDbCJGrid.pkg
Use cRDCDbCJGridColumn.pkg
Use cRDCForm.pkg
Use cRDCDbForm.pkg
Use cRDCButton.pkg
Use cRDCDbGroup.pkg
Use cRDCDbHeaderGroup.pkg

Use cCodeTypeDataDictionary.dd
Use cCodeMastDataDictionary.dd

Activate_View Activate_oCodesMaintenance for oCodesMaintenance
Object oCodesMaintenance is a cRDCDbView
    Set Label to "Maintain Codes"
    Set Location to 5 7
    Set Size to 235 283
    Set Icon to "Default.ico"
    Set psHtmlHelpTopic to "Maintain_Codes_View.htm"
    Set Auto_Clear_DEO_State to False
    Set pbAutoActivate to True

    Object oCodetype_DD is a cCodeTypeDataDictionary 
        Procedure OnConstrain
            Constrain CodeType.Type ne "SHIPPING"
        End_Procedure
    End_Object

    Object oCodemast_DD is a cCodemastDataDictionary
        Set DDO_Server To oCodetype_DD
        Set Constrain_File to CodeType.File_Number
    End_Object

    Set Main_DD To oCodetype_DD
    Set Server To oCodetype_DD
    
    On_Key Key_Alt+Key_F1 Send DoIt
    
    Procedure DoIt
        Boolean bState
        Get Cascade_Delete_State Of oCodetype_DD To bState
        Send Info_Box bSTate
    End_Procedure

    Object oCodeTypeGroup is a cRDCDbHeaderGroup
        Set Size to 114 275
        Set Location to 4 4
        Set peAnchors To anTopLeftRight
        Set Label to "Codes:"
        Set psNote to "Maintenance of Currencies and States"
        Set psImage to "Default.ico"
        
        Object oCodetype_Type is a cRDCDbForm
            Entry_Item CodeType.Type
            Set Label To "Type:"
            Set Size to 13 46
            Set Location to 30 60
        End_Object

        Object oCodetype_Description is a cRDCDbForm
            Entry_Item CodeType.Description
            Set Label To "Description:"
            Set Size to 13 201
            Set Location to 45 60
            Set peAnchors to anTopLeftRight
        End_Object

        Object Codetype_Comment is a cDbTextEdit
            Entry_Item CodeType.Comment
            Set Label To "Comment:"
            Set Size to 50 202
            Set Location to 60 60
            Set peAnchors To anTopLeftRight
            Set Label_Col_Offset To 2
            Set Label_Justification_Mode To JMode_Right
        End_Object

        // Return non-zero if table entry should not be allowed.
        //
        // Rules:
        // 1. if no data, disallow movement
        // 2. if new ask
        // 3. if old just save it
        //
        Function Allow_Child_Entry Returns Integer
            Handle hoObject hoServer 
            Integer iSaveMsg
            Boolean bHasRecord
        
            Get Server To hoServer
            Get HasRecord Of hoServer To bHasRecord
        
            // New unchanged record...don't allow
            If (Should_Save(Self) = 0 And bHasRecord = False) begin
                Send UserError "You must enter a Type Code first." ""
                Function_Return 1
            End
            // Save if needed
            If (bHasRecord Or Confirm(Self,"Save New Type Information?")=0) begin
                Get Verify_Save_MSG To iSaveMsg             // the old confirmation
                Set Verify_Save_MSG to (RefFunc(No_Confirmation))  // disable confirmation
                Send Request_Save_No_Clear                  // save it
                Set Verify_Save_MSG To iSaveMsg             // restore old confirm
            End
            // If save is still required, don't allow exit.
            Function_Return (Should_Save(Self))
        End_Function
    
    End_Object

    Object oCodeMastGrid is a cRDCDbCJGrid
        Set Server to oCodemast_DD
        Set Size to 77 275
        Set Location to 127 4
        Set pbHeaderReorders to True
        Set pbAutoAppend to True
        Set pbAllowAppendRow to True
        Set pbDrawGridForEmptySpace to True

        Object oCodeMast_Code is a cRDCDbCJGridColumn
            Entry_Item CodeMast.Code
            Set piWidth to 60
            Set psCaption to "Code"
        End_Object

        Object oCodeMast_Description is a cRDCDbCJGridColumn
            Entry_Item CodeMast.Description
            Set piWidth to 398
            Set psCaption to "Description"
        End_Object
        
        // we must ask the parent if it is OK to enter this
        Procedure OnEntering
            Integer iRetVal

            Get Allow_Child_Entry of oCodeTypeGroup to iRetVal
            If (iRetVal <> 0)  Begin
                Set pbNeedPostEntering to True
            End
        End_Function        
        
    End_Object

    Procedure Activating
        Forward Send Activating
        Send Request_Find of (Main_DD(Self)) FIRST_RECORD CodeType.File_Number 1
    End_Procedure

End_Object
