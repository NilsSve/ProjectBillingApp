Use cRDCDbView.pkg
Use cRDCDbGroup.pkg
Use cRDCDbCJGrid.pkg
Use cRDCDbCJGridColumn.pkg
Use cRDCForm.pkg
Use cRDCDbForm.pkg
Use cRDCButton.pkg
Use cRDCDbHeaderGroup.pkg

Use cInventoryDataDictionary.dd
Use Windows.pkg

Activate_View Activate_oInventoryView for oInventoryView
Object oInventoryView is a cRDCDbView
    Set Label to "Inventory"
    Set Location to 5 8
    Set Size to 124 307
    Set pbAutoActivate to True
    Set Icon to "Products.ico"

    Object oInventoryDataDictionary is a cInventoryDataDictionary
    End_Object

    Set Main_DD to oInventoryDataDictionary
    Set Server to oInventoryDataDictionary

    Object oInventory_grp is a cRDCDbHeaderGroup
        Set Location to 4 4
        Set Size to 114 299
        Set Label to "Inventory"
        Set psNote to "Registration of Services You Provide to Clients"
        Set psImage to "Products.ico"
        Set peAnchors to anTopLeftRight
    
        Object oInventory_Item_ID is a cRDCDbForm
            Entry_Item Inventory.Item_ID
            Set Label to "Invt. Item ID:"
            Set Size to 12 48
            Set Location to 44 70
            Set peAnchors to anNone
        End_Object
    
        Object oInventory_Description is a cRDCDbForm
            Entry_Item Inventory.Description
            Set Label to "Invt. Description:"
            Set Size to 12 210
            Set Location to 58 70
            Set peAnchors to anNone
        End_Object
        
        Object oInventory_Unit_Price is a cRDCDbForm
            Entry_Item Inventory.Unit_Price
            Set Label to "Unit Price:"
            Set Size to 12 48
            Set Location to 73 70
            Set peAnchors to anTopLeft
        End_Object

        Object oInventory_On_Hand is a cRDCDbForm
            Entry_Item Inventory.On_Hand
            Set Label to "On Hand:"
            Set Size to 12 36
            Set Location to 73 158
            Set peAnchors to anNone
        End_Object

    End_Object

End_Object
