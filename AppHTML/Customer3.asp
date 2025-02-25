<% '
   '  Customer Entry and Maintenance
   '

%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>Customer3</title>

<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>

<% CheckFieldChange=oCustomer.call("get_peFieldMultiUser") %>
<!-- #INCLUDE FILE="inc/SetChangedStates-script.inc" -->

<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

<% ' DebugMode =1 ' uncomment this for page get/post debug help %>
<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<h3>Multi-Page Data entry Screen Example</h3>


<font color="red">
<%
'
' This processes all GET and POST processes.
' If a GET we either need to display a record (which is passed
' in querystring) or clear the form. When a QueryString is passed
' it usually passed as an HREF from a report. This allows report line
' link to an entry form.
'
' If a POST one of the buttons was pressed and the data was posted
' back to itself. We must figure out what we are supposed to do
' (find, clear, save, delete, list) and do it.
'
'
' Note we will create and test the following variables
' Indx:          The current selected index
Indx = 1
CurrentPage = 1

If request("Request_method")="GET" Then

    ' if a GET see if a querystring Customer Rowid was passed. If it was
    ' we should find this record, else just clear the DDO

    RowId = request("RowId")
    If RowId <> "" Then
       ' this message is understood by the WebBusinessProcess01 class in VDF
       err = oCustomer.RequestFindbyRowId( "Customer", RowId )
       If Err = 0 then  CurrentPage = 2 else CurrentPage = 1
    Else
       Err = oCustomer.RequestClear("Customer",1)
    End If

else

    ' if here post request. We need to find out which submit button was
    ' pressed. Only the pressed button will be returned with the Post. So
    ' we can check to see if the button value exists (e.g. request("bname").
    ' This will return the buttons text value IF it was pressed and return
    ' a blank if it were not pressed. So, if Request("bname")<>"" is was pressed

    if Request("clear")<>"" then
        Err = oCustomer.RequestClear("Customer",1)
    end if

    if Request("find")<>"" then  Err = oCustomer.RequestFind("Customer", Indx, EQ) ' Find EQ

    if Request("next")<>"" then
        CurrentPage =2
        err = oCustomer.RequestDDUpdate("Customer",0)
        if err then
           ' we only care if the error is one of the items on this page. We must check each
           ' item for an error here.
           FErr = oCustomer.DDValue("Customer.Customer_Number",DDFIELDERROR)
           if FErr = "" then FErr = oCustomer.DDValue("Customer.Name",DDFIELDERROR)
           if FErr = "" then FErr = oCustomer.DDValue("Customer.Phone_Number",DDFIELDERROR)
           if FErr <>"" then
              CurrentPage=1
              Response.write("<strong>Errors exist on this page which must be corrected</strong>")
           end if
        end if
    end if

    if Request("back")<>"" then
        err = oCustomer.RequestDDUpdate("Customer",0)
        CurrentPage=1
    end if


    if Request("save")<>"" then
        ' note that we can return a value here.
        err = oCustomer.RequestSave("Customer")
        if err = 0 then
            Response.Write("<center> <h4>Thank you for sending your information.</h4> </center>")
            CurrentPage=1
        else
            Response.Write("<center> <h4>Could not save changes. Errors Occurred</h4> </center>")
            CurrentPage=2
        end if
    end if

    if Request("validate")<>"" then
        err = oCustomer.RequestDDUpdate("Customer",0)
        if Err = 0 then
            Response.Write("<center> <h4>Current data is Valid</h4> </center>")
        else
            Response.Write("<center> <h4>Current data is not valid</h4> </center>")
        end if
        CurrentPage=2
    end if

end if


%>

</font>

<% If Currentpage = 1 then %>

<form ACTION="Customer3.asp" METHOD="POST" NAME="Customer_WBO" OnSubmit="SetChangedStates(this)">
  <input type="hidden" name="Customer__RowId" value="<%=oCustomer.DDValue("Customer.RowId")%>">
  <input type="hidden" name="ChangedStates" value="">

  <p>
    <input type="submit" name="clear" value="Clear">
    <input type="submit" value="Find by Id" name="find">
  </p>
  
  <blockquote>
    <%  ' build table of input items for page 1 %>
    <table border="0" Class="EntryTable">

  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Customer_Number",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Customer_Number",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Customer_Number",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Name",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Name",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Name",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Phone_Number",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Phone_Number",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Phone_Number",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
</table>
  </blockquote>
  <p>
    <input type="submit" name="Next" value="Next Page">
  </p>
</form>

<% else %>

<form ACTION="Customer3.asp" METHOD="POST" NAME="Customer_WBO" OnSubmit="SetChangedStates(this)">
  <%
     CustRowId=oCustomer.DDValue("Customer.RowId")
     CustNum=oCustomer.DDValue("Customer.Customer_number")
     CustNam=oCustomer.DDValue("Customer.Name")
     CustPhn=oCustomer.DDValue("Customer.phone_number")
  %>
  <input type="hidden" name="Customer__RowId" value="<%=CustRowId%>">
  <input type="hidden" name="ChangedStates" value="">

  <input type="hidden" name="Customer__Customer_Number" value="<%=CustNum%>">
  <input type="hidden" name="Customer__Name" value="<%=CustNam%>">
  <input type="hidden" name="Customer__phone_number" value="<%=CustPhn%>">

  <p>
    <A HREF="#" onClick="history.go(-1);return false;">Previous Page</A>
  </p>
  
  <blockquote>
    <h3>
    <% If CustRowId="" then %>
    Adding a New Customer<br>
    <% else %>
    Editing Customer Number <strong><%=CustNum%></strong><br>
    <% end if %>
    </h3>

    <table border="0" Class="EntryTable">
    <tr><td Class="Label">Customer Name: </td><td><%=CustNam%></td></tr>
    <tr><td Class="Label">Customer Phone: </td><td><%=CustPhn%></td></tr>
    </table>
    <br>

    <table border="0" Class="EntryTable">

  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Address",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Address",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Address",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Status",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Status",DDLONGLABEL,1)%></td>
      <td Class="Data">
     <%=oCustomer.DDValue("Customer.Status",DDAuto)%>      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.City",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.City",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.City",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.State",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.State",DDLONGLABEL,1)%></td>
      <td Class="Data">
     <%=oCustomer.DDValue("Customer.State",DDAuto)%>      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Zip",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Zip",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Zip",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Fax_Number",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Fax_Number",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Fax_Number",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Email_Address",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Email_Address",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Email_Address",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Credit_Limit",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Credit_Limit",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Credit_Limit",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Purchases",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Purchases",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Purchases",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Balance",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Balance",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Balance",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>
  <tr>
      <%FieldError=oCustomer.DDValue("Customer.Comments",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Comments",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Comments",DDAuto)%>
      </td>
      <% If FieldError<>"" then %>
      <td Class="Error"><%=FieldError%></td>
      <% end if %>
  </tr>

</table>
  </blockquote>
  <p>
    <input type="submit" name="save" value="Save">
    <input type="submit" name="validate" value="Validate">
  </p>
</form>

<% end if %>
</body>
</html>