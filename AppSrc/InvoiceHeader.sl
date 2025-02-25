Use cRDCDbModalPanel.pkg
Use cRDCDbCJGridPromptList.pkg
Use cRDCDbCJGridColumn.pkg
Use cRDCButton.pkg

Use cInventoryDataDictionary.dd
Use cCustomerDataDictionary.dd
Use cInvoiceHeaderDataDictionary.dd

Object oInvoHea_sl is a cRDCDbModalPanel
    Set Location to 5 5
    Set Size to 134 382
    Set Label To "Invoices Lookup List"
    Set Minimize_Icon to False

    Object oInvt_DD is a cInventoryDataDictionary
    End_Object 

    Object oCustomer_DD is a cCustomerDataDictionary
        Set DDO_Server to oInvt_DD
    End_Object 

    Object oInvoHea_DD is a cInvoiceHeaderDataDictionary
        Set DDO_Server To oCustomer_DD
    End_Object 

    Set Main_DD To oInvoHea_DD
    Set Server  To oInvoHea_DD

    Object oSelList is a cRDCDbCJGridPromptList
        Set Size to 105 372
        Set Location to 5 5
        Set Ordering to 1
        Set pbAutoServer to True
        Set pbAutoOrdering to True
        Set pbAutoSearch to True
        Set pbAutoSeed to True
        Set pbFullColumnScrolling to True
        Set pbHeaderSelectsColumn to True
        Set pbInitialSelectionEnable to True

        Object oInvoHea_Invoice_Number is a cRDCDbCJGridColumn
            Entry_Item InvoiceHeader.Invoice_Number
            Set piWidth to 65
            Set psCaption to "Invoice #"
        End_Object 

        Object oCustomer_Customer_Number is a cRDCDbCJGridColumn
            Entry_Item Customer.Customer_Number
            Set piWidth to 78
            Set psCaption to "Customer #"
        End_Object 

        Object oCustomer_Name is a cRDCDbCJGridColumn
            Entry_Item Customer.Name
            Set piWidth to 250
            Set psCaption to "Customer Name"
        End_Object 

        Object oInvoHea_Invoice_Date is a cRDCDbCJGridColumn
            Entry_Item InvoiceHeader.Invoice_Date
            Set piWidth to 100
            Set psCaption to "Date"
        End_Object 

        Object oInvoHea_Invoice_Total is a cRDCDbCJGridColumn
            Entry_Item InvoiceHeader.Invoice_Total
            Set piWidth to 110
            Set psCaption to "Total"
        End_Object 

    End_Object 

    Object oOk_bn is a cRDCButton
        Set Label to C_$OkButtonLabel
        Set Location to 115 219
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send OK of oSelList
        End_Procedure

    End_Object 

    Object oCancel_bn is a cRDCButton
        Set Label to C_$CancelButtonLabel
        Set Location to 115 273
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure

    End_Object 

    Object oSearch_bn is a cRDCButton
        Set Label to C_$SearchButtonLabel
        Set Location to 115 327
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Search of oSelList
        End_Procedure

    End_Object 

    On_Key Key_Alt+C_$OkAcceleratorKey Send KeyAction of oOk_bn
    On_Key Key_Alt+C_$CancelAcceleratorKey Send KeyAction of oCancel_bn
    On_Key Key_Alt+C_$SearchAcceleratorKey Send KeyAction of oSearch_bn
End_Object
