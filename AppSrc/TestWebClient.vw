// Register all objects
Register_Object oClientTest
Register_Object oTestCustService
Register_Object oWSCustService

Use dfClient.pkg
Use Windows.pkg
Use cWSCustService.pkg

DEFERRED_VIEW Activate_oClientTest FOR ;
;
Object oClientTest is a dbView
    Set Border_Style to Border_Thick
    Set Label to "Test Web Service"
    Set Location to 8 5
    Set Size to 106 121

    Object oTestCustService is a Button
        Set Label to "Test Cust Service"
        Set Size to 14 81
        Set Location to 34 13
        Set peAnchors to anBottomRight

        Procedure OnClick
            string sReply
            date dDate
            dateTime dtDateTime
            Boolean bOk
        
            Get wsSayHello   of oWSCustService "John" to sReply
            Showln "Say Hello   " sReply
        
            Get wsSayGoodBye   of oWSCustService "John" "Tuohy" to sReply
            Showln "Say Goodbye   " sReply
        
            sysdate dDate
            Get wsTestDateArgument of oWSCustService dDate to sReply
            Showln "TestDateArgument   " sReply
        
            Move (CurrentdateTime()) to dtDateTime
            Get wsTestDateTimeArgument of oWSCustService dtDateTime to sReply
            Showln "TestDateTimeArgument   " sReply
        
            Get wsTestNumber of oWSCustService dtDateTime to sReply
            Showln "TestNumber   " sReply
       
        End_Procedure // OnClick

    End_Object    // oTestCustService

    Object oWSCustService is a cWSCustService
        
        // Web Service Class is defined in cWSCustService.pkg
        //
        // Interface:
        //
        // Function wsSayHello string llsName returns string
        // Function wsEcho string llechoString returns string
        // Function wsSayGoodbye string llFirstName string llLastName returns string
        // Function wsTestNumber returns decimal
        // Function wsTestDate returns date
        // Function wsTestTime returns time
        // Function wsTestDateTime returns dateTime
        // Function wsTestDateArgument date lldDate returns string
        // Function wsTestDateTimeArgument dateTime lldDate returns string
        // Function wsTestComplex handle llblah returns handle
        // Function wsPlaceOrder handle llorder returns integer
        
        // phoSoapClientHelper
        //     Setting this property will pop up a view that provides information
        //     about the Soap (xml) data transfer. This can be useful in debugging.
        //     If you use this you must make sure you USE the test view at the top
        //     of your program/view by adding:   Use WebClientHelper.vw // oClientWSHelper
        //Set phoSoapClientHelper to oClientWSHelper
        
    End_Object    // oWSCustService

CD_End_Object    // oClientTest
