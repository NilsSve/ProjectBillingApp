Use dfClient.pkg
Use DataDict.pkg
Use dfEntry.pkg
Use cDbScrollingContainer.pkg
Use cVendorDataDictionary.DD
Use cInventoryDataDictionary.DD

Deferred_View Activate_oTabbedInventoryView for ;
;
Object oTabbedInventoryView is a dbView
    Set Border_Style to Border_Thick
    Set Label to "Inventory Item View"
    Set Location to 5 8
    Set Size to 151 305
    Set piMaxSize to 151 350
    
    Object Vendor_DD is a cVendorDataDictionary
    End_Object
    
    Object Inventory_DD is a cInventoryDataDictionary
        Set DDO_Server to Vendor_DD
    End_Object
    
    Set Main_DD to Inventory_DD
    Set Server to Inventory_DD
    
    Object oScrollingContainer1 is a cDbScrollingContainer
        
        Object oScrollingClientArea1 is a cDbScrollingClientArea
            Object oInvt_Item_ID is a dbForm
                Entry_Item Inventory.Item_ID
                Set Label to "Item ID:"
                Set Size to 12 60
                Set Location to 10 70
                Set peAnchors to anTopLeft
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
            End_Object
            
            Object oInvt_Description is a dbForm
                Entry_Item Inventory.Description
                Set Label to "Description:"
                Set Size to 12 210
                Set Location to 24 70
                Set peAnchors to anTopLeftRight
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
            End_Object
            
            Object oVendorGroup is a dbGroup
                Set Size to 58 271
                Set Location to 41 9
                Set peAnchors to anLeftRight
                Set Label to "Vendor"
                Object oInvt_Vendor_ID is a dbForm
                    Entry_Item Vendor.ID
                    Set Label to "Vendor ID:"
                    Set Size to 12 42
                    Set Location to 9 61
                    Set peAnchors to anTopLeft
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
                Object oVendor_Name is a dbForm
                    Entry_Item Vendor.Name
                    Set Label to "Vendor Name:"
                    Set Size to 12 180
                    Set Location to 23 61
                    Set peAnchors to anTopLeftRight
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
                Object oInvt_Vendor_Part_ID is a dbForm
                    Entry_Item Inventory.Vendor_Part_ID
                    Set Label to "Vendor Part ID:"
                    Set Size to 12 90
                    Set Location to 37 61
                    Set peAnchors to anTopLeft
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
            End_Object
            
            Object oUnitGroup is a dbGroup
                Set Size to 28 271
                Set Location to 101 10
                Set peAnchors to anLeftRight
                Object oInvt_Unit_Price is a dbForm
                    Entry_Item Inventory.Unit_Price
                    Set Label to "Unit Price:"
                    Set Size to 12 48
                    Set Location to 10 61
                    Set peAnchors to anTopLeft
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
                Object oInvt_On_Hand is a dbForm
                    Entry_Item Inventory.On_Hand
                    Set Label to "On Hand:"
                    Set Size to 12 36
                    Set Location to 10 205
                    Set peAnchors to anTopRight
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
            End_Object
            
        End_Object
    End_Object
    
Cd_End_Object


