<% '
   '  Customer Entry and Maintenance
   '

   'Initialize Standard Information
   Index     = request("Index")           ' The last selected Index number
   RowId     = request("RowId")           ' If a row Id was passed
   RunReport = (request("RunReport")<>"") ' If run report was selected
%>

<% ' redirects must occur before any html output!
    If RunReport then
        Response.redirect ("CustomerList.asp?RunReport=1&Index=" & Index)
    end if
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>Customer1</title>

<% ' LoginRights:   If 1 user has full rights, if 0 or -1, browse only rights %>
<% LoginRights = request.cookies("Rights") %>

<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>


<% CheckFieldChange=oCustomer.call("get_peFieldMultiUser") %>
<!-- #INCLUDE FILE="inc/SetChangedStates-script.inc" -->

<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

<% ' DebugMode =1 ' uncomment this for page get/post debug help %>
<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<% If LoginRights = "1" then %>
<h3>Customer Entry and Maintenance</h3>
<% else %>
<h3>Customer Query</h3>
<% end if %>

<%
  oCustomer.call "set_pbReportErrors", 1 'normally show any errors that occur
  'We either find a record, or clear the WBO
  If RowId <> "" Then
      Err = oCustomer.RequestFindbyRowId( "Customer", RowId)
  else
      Err = oCustomer.RequestClear("Customer",1)
  End if

  ' process various buttons that might have been pressed.
  ' only support Post submissions
  If request("Request_method")="POST" Then

      if Request("clear")<>"" then
          Err = oCustomer.RequestClear("Customer",1)
      end if

      if Request("save")<>"" then
          oCustomer.call "set_pbReportErrors", 0
          err = oCustomer.RequestSave("Customer")
          if err = 0 then
              Response.Write("<center> <h4>Customer record saved</h4> </center>")
          else
              Response.Write("<font color=""red"">")
              Response.Write("<center> <h4>Could not save changes. Errors Occurred</h4> </center>")
              oCustomer.call "msg_ReportAllErrors"
              Response.Write("</font>")
          end if
      end if

      if Request("delete")<>"" then
          oCustomer.call "set_pbReportErrors", 0
          Err = oCustomer.RequestDelete("Customer")
          if err = 0 then
             Response.Write("<center> <h4>The record has been deleted.</h4> </center>")
          else
             Response.Write("<font color=""red"">")
             Response.Write("<center> <h4>The record could not be deleted.</h4> </center>")
             oCustomer.call "msg_ReportAllErrors"
             Response.Write("</font>")
          end if
      end if

      ' note we use the Index variable we created above
      if Request("findprev") <>"" then  Err = oCustomer.RequestFind("Customer", Index, LT)
      if Request("find")     <>"" then  Err = oCustomer.RequestFind("Customer", Index, GE)
      if Request("findnext") <>"" then  Err = oCustomer.RequestFind("Customer", Index, GT)
      if Request("findfirst")<>"" then  Err = oCustomer.RequestFind("Customer", Index, FIRST_RECORD)
      if Request("findlast") <>"" then  Err = oCustomer.RequestFind("Customer", Index, LAST_RECORD)

 end if

%>


<Form action="Customer1.asp" method="POST" name="Customer" onsubmit="SetChangedStates(this)">

<% ' You MUST have a hidden rowid field for each DDO in your WBO %>
<input type="hidden" size="15" name="Customer__RowId" Value="<%=oCustomer.DDValue("Customer.RowId")%>" >
<% ' This is needed if you need field level change state checking %>
<Input type="hidden" name="ChangedStates" value="">

<p class="Toolbar">
Find
<input Class="ActionButton" type="submit" name="findfirst" value="&lt;&lt;">
<input Class="ActionButton" type="submit" name="findprev" value="&lt;">
<input Class="ActionButton" type="submit" name="find" value="=">
<input Class="ActionButton" type="submit" name="findnext" value="&gt;">
<input Class="ActionButton" type="submit" name="findlast" value="&gt;&gt;">
<input Class="ActionButton" type="submit" name="RunReport" value="List">
 by
<% oCustomer.call "get_CreateFindIndexCombo", "Index", "Customer", Index %>
<% If LoginRights = "1" then %>
&nbsp;&nbsp;
<input Class="ActionButton" type="submit" name="save" value="Save">
<input Class="ActionButton" type="submit" name="delete" value="Delete">
<input Class="ActionButton" type="submit" name="clear" value="Clear">
<% end if %>
</p>

<blockquote class="EntryBlock">


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
      <%FieldError=oCustomer.DDValue("Customer.Phone_Number",DDFIELDERROR) %>
      <td Class="Label"><%=oCustomer.DDValue("Customer.Phone_Number",DDLONGLABEL,1)%></td>
      <td Class="Data">
      <%=oCustomer.DDValue("Customer.Phone_Number",DDAuto)%>
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

</form>

</body>
</html>