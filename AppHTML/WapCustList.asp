<% Response.ContentType = "text/vnd.wap.wml"%><?xml version="1.0"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">

<%
   ' This sample, WapCustList.asp, and its complement, WapCustomerMaint.asp were created using the WAP
   ' entry and report wizard. These two wizards are designed to work together providing a simple
   ' model for displaying lists of data, displaying "form" information for each line of data, and
   ' for editing the data. It's not easy to add, edit and deletes customers from a cell phone, but
   ' with a little practice it can be done.
   '
   ' This is 100% wizard generated except for additonal comments that have been added to the page
   '
   ' This uses the WBO oWapCustList (WapCustList.wbo). It contains a Wml report that fetches the
   ' required customer records and displays them. You will want to study this WBO
%>

<% '
   '  Wap Customer List
   '

   ' Action = RptInit|RptSeed|RptRun
   Action=request("Action")

   ' determines how many record will be output. Should be kept short. Remember that a
   ' WML page limit is usually around 1400 bytes. 9 is a good choice because each option
   ' can be directly selected using to 1-9 keypad on the phone.
   MaxLines  = 9 ' maximum records per report

   ' In addition to watching how many records, we want to keep track of number of bytes. This
   ' value should be approximiate as it is tested before the next line will be output. So 1000
   ' is a good guess to keep the size under 1400
   MaxChars  = 1000 ' approximate maximum characters per deck

   ' Name of "Zoom" form. In this case, we point back to our entry page (which, in turn, points back
   ' to this page)
   ZoomURL   = "WapCustomerMaint.asp" ' name of zoom file. If blank none.

   Url = Request.ServerVariables("URL")

   ' We actually don't use this, but you may want it for customer changes
   RowId=request("RowId")

   ' index to report by
   Index  = Request("Index")
   if Index = "" then Index = 1

   ' Where to start the report. Used to allow reports to be broken up into smaller
   ' pages
   StartRowId=request("Start")

   ' Fixes Post bug: See WapCustomerMaint.asp
   Randomize:   RID=int(Rnd * 1000)
%>

<wml>
<head>
    <meta forua="true" http-equiv="Cache-Control" content="must-revalidate"/>
</head>
<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->


<% if Action="" or Action="RptInit" then  %>

<%
  '-----------------------------------------------------------
  ' Initialize the Report
  '    Ask for Index order and Post data, which will then
  '    do a seed. We have to break the init and seed into two
  '    steps to keep the deck size small
  '-----------------------------------------------------------
%>

<card id="Index" newcontext="true" >

<p align="center">
    <b>Wap Customer List</b>
</p>
<p>
    <b>Select Order</b><br/>
      <select name="index" value="<%=Index%>">
        <option value="1" >Number</option>
        <option value="2" >Customer Name</option>
        <option value="3" >Balance</option>
      </select>
</p>
<do type="accept" label="Ok">
    <go href="<%=URL%>?Rnd=<%=RID%>" method="post">
        <postfield name="Action"  value="RptSeed"/>
        <postfield name="Index"   value="$(index)"/>
    </go>
</do>
</card>

<% end if %>

<% if Action="RptSeed" then  %>

<%
  '-----------------------------------------------------------
  ' Seed the Report
  '    Find the place to start the report
  '    and then do a post to run the report
  '-----------------------------------------------------------
%>


<%
    fieldname = oWapCustList.call("get_IndexMainField","Customer",Index)
    FFName = "customer__" & fieldname
    IndexName = oWapCustList.ddValue( "customer." & fieldname,DDLONGLABEL)
%>
<card id="Seed" newcontext="true" >
<p align="center">
    <b>Wap Customer List</b>
</p>
<p>
   Please enter start<br/><b><%=IndexName %>:</b>
   <input name="content" />
</p>
<do type="accept" label="Ok">
    <go href="<%=URL%>?Rnd=<%=RID%>" method="post">
        <postfield name="Action"  value="RptRun"/>
        <postfield name="Index"   value="<%=Index%>"/>
        <postfield name="<%=FFName%>" value="$(content)"/>
    </go>
</do>
</card>
<% end if %>

<% if Action="RptRun" then %>

<%
  '-----------------------------------------------------------
  ' Run the Report
  '    Pass needed setup information to the report WBO
  '    which generates the report
  '-----------------------------------------------------------
%>
<card id="Rpt" newcontext="true" >

<p align="center">
    <b>Wap Customer List</b>
</p>
<p mode="wrap">

<%

   ' if we don't have a start ID, get the first record for the
   ' requested index.
   If StartRowId="" then
      Err = oWapCustList.RequestFind("Customer", Index, GE)
      StartRowId = oWapCustList.ddValue("Customer.RowId")
   end if

   ' the Zoom form name. When developer selects a customer they can zoom to this URL
   oWapCustList.call "msg_SetHRefName", ZoomUrl

   ' Max characters allowed in deck and max lines per report (whichever comes first)
   oWapCustList.call "msg_SetMaxChars", MaxChars
   oWapCustList.call "msg_SetMaxLines", MaxLines

   ' Run the report, pass Index and start Id, return end ID (next record in list)
   EndRowId   = oWapCustList.call("get_RunWapCustList", Index, StartRowId)

%>

<% ' If there are still records, we need to create a More option to allow continuation
   ' of the report %>
<% if EndRowId<>"" then %>
   <do type="options" label="More..">
      <go href="<%=URL%>?Rnd=<%=RID%>" method="post">
          <postfield name="Action"  value="RptRun"/>
          <postfield name="Index"   value="<%=Index%>"/>
          <postfield name="Start"   value="<%=EndRowId%>"/>
      </go>
   </do>
<% end if %>
<do type="options" label="New Report">
   <go href="<%=URL%>?Index=<%=Index%>"/>
</do>

</p>
</card>

<% end if %>

</wml>