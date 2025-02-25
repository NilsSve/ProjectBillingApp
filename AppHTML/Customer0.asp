<% '
   '  Customer Entry and Maintenance
   '

   'Initialize Standard Information
   Index     = request("Index")           ' The last selected Index number
   RowId     = request("RowId")           ' If a record Id was passed
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
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<title>Customer0</title>

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

      if Request("validate")<>"" then
          oCustomer.call "set_pbReportErrors", 0
          err = oCustomer.RequestDDUpdate("Customer",0)
          if Err = 0 then
              Response.Write("<center> <h4>Current data is Valid</h4> </center>")
          else
              Response.Write("<font color=""red"">")
              Response.Write("<center> <h4>Current data is not valid</h4> </center>")
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

<%
' generate a row for the passed obj and field
' The advantage of this method is you can control your output
' anyway you want and propagate it to all input controls
Sub ShowDataLine (Obj, FileField )

    FErr = Obj.DDValue(FileField,DDFIELDERROR)

    Response.write("<tr>")

    Response.write( "<td>Doing it with a sub-routine</td>")

    Response.write( "<td align=""right""><strong>")
    If FErr<>"" then Response.Write("<font color=""red"">") else Response.Write("<font>")
    Response.write( Obj.ddValue(FileField, DDLONGLABEL) & "</font></strong></td>")

    Response.write( "<td>" & Obj.DDValue(FileField,DDAUTO) & "</td>")

    If FErr <> "" then
       Response.write("<td><font color=""red"">" & FErr & "</font></td>")
    end if

    Response.write("</tr>")

End Sub


%>

</font>

<form ACTION="Customer0.asp" METHOD="POST" NAME="Customer_WBO" OnSubmit="SetChangedStates(this)">
  <input type="hidden" name="Customer__RowId" value="<%=oCustomer.DDValue("Customer.RowId")%>">
  <input type="hidden" name="ChangedStates" value="">

<p class="Toolbar">
Find
<input Class="ActionButton" type="submit" name="findfirst" value="&lt;&lt;">
<input Class="ActionButton" type="submit" name="findprev" value="&lt;">
<input Class="ActionButton" type="submit" name="find" value="=">
<input Class="ActionButton" type="submit" name="findnext" value="&gt;">
<input Class="ActionButton" type="submit" name="findlast" value="&gt;&gt;">
 by
<% oCustomer.call "get_CreateFindIndexCombo", "Index", "Customer", Index %>
</p>

<blockquote class="EntryBlock">

    <table class="entryTable" width=99%>

      <tr><td colspan="3"><strong><big>Various ways to make single line entries work</big></strong></td></tr>
      <tr>
        <td>Simple single line entry</td>
        <td align="right"><strong>Customer Number</strong></td>
        <td><input type="text" size="6" Title="Customer Id Number (system assigned)."
             name="CUSTOMER__CUSTOMER_NUMBER" value="<%=oCustomer.DDValue("Customer.Customer_Number")%>">
        </td>
      </tr>

      <tr>
        <td>Alternate Simple single line entry</td>
        <%sValue = oCustomer.DDValue("Customer.Customer_Number")%>
        <td align="right"><strong>Customer Number</strong></td>
        <td><input type="text" size="6" Title="Customer Id Number (system assigned)."
             name="CUSTOMER__CUSTOMER_NUMBER" value="<%=sValue%>">
        </td>
      </tr>


      <tr>
        <td>Simple single line entry w/ error check</td>
        <%FieldError=oCustomer.DDValue("Customer.Customer_Number",DDFIELDERROR)%>
        <td align="right"><strong>Customer Number</strong></td>
        <td><input type="text" size="6" Title="Customer Id Number (system assigned)."
             name="CUSTOMER__CUSTOMER_NUMBER" value="<%=oCustomer.DDValue("Customer.Customer_Number")%>">
        </td>
        <%If FieldError<>"" then%>
            <td><font color="red"><%=FieldError%></font></td>
        <%end if%>
      </tr>

      <tr>
        <td>Simple single line entry w/ auto-status help</td>
        <td align="right"><strong>Customer Number</strong></td>
        <td><input type="text" size="6" Title="<%=oCustomer.DDValue("Customer.Customer_Number",DDSTHELP)%>"
             name="CUSTOMER__CUSTOMER_NUMBER" value="<%=oCustomer.DDValue("Customer.Customer_Number")%>">
        </td>
      </tr>

      <tr>
        <td>Simple single line entry with auto label</td>
        <td align="right"><strong><%=oCustomer.DDValue("Customer.Customer_Number",DDLONGLABEL)%></strong></td>
        <td><input type="text" size="6" Title="Customer Id Number (system assigned)."
             name="CUSTOMER__CUSTOMER_NUMBER" value="<%=oCustomer.DDValue("Customer.Customer_Number")%>">
        </td>
      </tr>

      <tr>
        <td>Simple single line entry with auto label w/error info</td>
        <td align="right"><strong><%=oCustomer.DDValue("Customer.Customer_Number",DDLONGLABEL,2)%></strong></td>
        <td><input type="text" size="6" Title="Customer Id Number (system assigned)."
             name="CUSTOMER__CUSTOMER_NUMBER" value="<%=oCustomer.DDValue("Customer.Customer_Number")%>">
        </td>
      </tr>

<tr>
        <td>auto generated single line entry</td>
        <td align="right"><strong>Customer Number</strong></td>
        <td><%=oCustomer.DDValue("Customer.Customer_Number",DDFORM)%></td>
      </tr>

      <tr>
        <td>auto DDAUTO generated single line entry</td>
        <td align="right"><strong>Customer Number</strong></td>
        <td><%=oCustomer.DDValue("Customer.Customer_Number",DDAUTO)%></td>
      </tr>

      <tr>
        <td>Doing it all</td>
        <%FieldError=oCustomer.DDValue("Customer.Customer_Number",DDFIELDERROR)%>
        <td align="right"><strong><%=oCustomer.DDValue("Customer.Customer_Number",DDLONGLABEL,1)%></strong></td>
        <td><%=oCustomer.DDValue("Customer.Customer_Number",DDAUTO)%></td>
        <%If FieldError<>"" then%>
            <td><font color="red"><%=FieldError%></font></td>
        <%end if%>
      </tr>

      <% ShowDataLine oCustomer, "Customer.Customer_Number" ' do it with a subroutine %>

      <tr><td colspan="3"><strong><big>Various ways to make validation tables work</big></strong></td></tr>
      <tr>
        <td>Val table as form w/ error display</td>
        <%FieldError=oCustomer.DDValue("Customer.State",DDFIELDERROR)%>
        <td align="right"><strong>State</strong></td>
        <td><%=oCustomer.ddValue("Customer.State", DDFORM)%></td>
        <%If FieldError<>"" then%>
            <td><font color="red"><%=FieldError%></font></td>
        <%end if%>
      </tr>

      <tr>
        <td>Val table as combo take 1</td>
        <td align="right"><strong>State</strong></td>
        <td><select Size="1" name="CUSTOMER__STATE">
            <%=oCustomer.ddValue("Customer.State", DDOPTION)%>
            </select></td>
      </tr>
      <tr>
        <td>Val table as combo take 2 DDCOMBO</td>
        <td align="right"><strong>State</strong></td>
        <td><%=oCustomer.ddValue("Customer.State", DDCOMBO)%></td>
      </tr>
      <tr>
        <td>Val table as combo take 3 DDAUTO</td>
        <td align="right"><strong>State</strong></td>
        <td><%=oCustomer.ddValue("Customer.State", DDAUTO)%></td>
      </tr>
      <tr>
        <td>Val table as a radio</td>
        <td align="right"><strong>State</strong></td>
        <td><%=oCustomer.DDValue("Customer.State",DDRADIO)%></td>
      </tr>


      <tr><td colspan="3"><strong><big>Various ways to make display only fields work</big></strong></td></tr>
      <tr>
        <td>Read only field (w/ no displayonly)</td>
        <td align="right"><strong>Purchases</strong></td>
        <td><input type="text" size="8"
             name="CUSTOMER__PURCHASES" value="<%=oCustomer.DDValue("Customer.Purchases")%>">
        </td>
      </tr>

      <tr>
        <td>Read only field (w/ manual displayonly)</td>
        <td align="right"><strong>Purchases</strong></td>
        <td><input type="text" size="8" READONLY
             name="CUSTOMER__PURCHASES" value="<%=oCustomer.DDValue("Customer.Purchases")%>">
        </td>
      </tr>

      <tr>
        <td>Read only field (w/ auto displayonly)</td>
        <td align="right"><strong>Purchases</strong></td>
        <td><input type="text" size="8" <%=oCustomer.DDValue("Customer.Purchases",DDREADONLY)%>
             name="CUSTOMER__PURCHASES" value="<%=oCustomer.DDValue("Customer.Purchases")%>">
        </td>
      </tr>

      <tr>
        <td>Read only field via DDAUTO or DDFORM</td>
        <td align="right"><strong>Purchases</strong></td>
        <td><%=oCustomer.DDValue("Customer.Purchases",DDAUTO)%></td>
      </tr>

      <tr>
        <td>Read only field without using control</td>
        <td align="right"><strong>Purchases</strong></td>
        <td><em><strong><%=oCustomer.DDValue("Customer.Purchases")%></strong></em></td>
      </tr>

      <tr><td colspan="3"><strong><big>Various ways to make multi-line (comments) work</big></strong></td></tr>
      <tr>
        <td>Comment done manually</td>
        <td align="right"><strong>Comments</strong></td>
        <td><textarea rows="5" cols="40" Title="Additional Comments and Notes."
              name="CUSTOMER__COMMENTS" ><%=oCustomer.DDValue("Customer.Comments")%>
        </textarea></td>
      </tr>

      <tr>
        <td>Comment done DDEDIT</td>
        <td align="right"><strong>Comments</strong></td>
        <td><%=oCustomer.DDValue("Customer.Comments",DDEDIT)%></td>
      </tr>

      <tr>
        <td>Comment done DDAUTO</td>
        <td align="right"><strong>Comments</strong></td>
        <td><%=oCustomer.DDValue("Customer.Comments",DDAUTO)%></td>
      </tr>

    </table>
  </blockquote>
</form>

</body>
</html>

