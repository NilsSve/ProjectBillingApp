<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>More about the Data Entry and Report Example</title>
<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>

<h3>More about the Data Entry and Report Example</h3>

<p><a href="MoreHtml.asp">More About </a><a href="MoreHtml.asp">HTML</a>&nbsp;&nbsp;&nbsp;
<a href="MoreWml.asp">More
About WML</a>&nbsp;&nbsp;&nbsp; More About Web Services</p>

<h4>The Web Service Samples</h4>
<p>Visual DataFlex Web Application Server is capable of doing more than just
providing HTML pages to an internet browser. It can also be used to provide
Web Services. By making simple URL requests you can support XML based web
services using established standard technologies such as as XML, WSDL and SOAP.
The Visual DataFlex Web Application Server dynamically generates the WSDL and a
set of HTML test pages based on the exposed Web Service methods, letting you
concentrate on the functionality of your Web Service rather than low level Web
Service details. The Web Service samples are divided in three.</p>

<h4>Visual DataFlex Test Web Service</h4>
<p>This sample demonstrates a few simple services and how you can
easily expose VDF object methods as Web Services. You can extend this sample
by creating your own object method and simply publishing it from within
the Studio. The Visual DataFlex Web Application Server automatically takes care
of the rest, including keeping the WSDL and HTML test pages up to date.
You can access the sample from within your browser using the <a href="TestService.wso">HTML test pages</a>,
or you can use a SOAP client such as Visual DataFlex or Microsoft .NET to
access the sample using the SOAP protocol. Simply point your SOAP client
generator to the <a href="TestService.wso?WSDL">WSDL</a>.
</p>
HTML Test Page: <a href="TestService.wso">TestService.wso</a><br/>
WSDL: <a href="TestService.wso?WSDL">TestService.wso?WSDL</a>

<h4>Customer and Order Information Service</h4>
<p>The second sample demonstrates a little more complex Web Service scenario,
passing and returning different sets of complex data utilizing struct types and
arrays. It allows you to retrieve detailed order information for example.</p>

<p>While many Web Services work with simple data types such as Integer, String
and Date, some Web Services may require more complex data. Struct types and
arrays are ideally suited for such Web Services. You can define complex
struct types, such as a complete order, containing among other things, all order
line items as well as shipping address and so forth. The Visual DataFlex Web
Application Server automatically takes care of describing your data structure
to Web Service clients through the WSDL, allowing various Web Service clients
to easily use your Web Service.</p>

<p>
HTML Test Page: <a href="CustomerAndOrderInfo.wso">CustomerAndOrderInfo.wso</a><br/>
WSDL: <a href="CustomerAndOrderInfo.wso?WSDL">CustomerAndOrderInfo.wso?WSDL</a>
</p>

<h4>Customer XML Service</h4>
<p>The third sample demonstrates an alternative for passing and returning
complex set of data as pure XML, utilizing the cXmlDomDocument class in Visual
DataFlex.</p>

<p>As a lower level alternative to the use of struct types and arrays for
complex parameters, you can specify data to be passed as pure XML using
cXmlDomDocument objects. This is a very flexible and powerful method which lets
you take complete control over each parameter and the return value. Using
XmlHandle as a parameter type and/or return type, gives you the flexibility of
this powerful feature on individual parameters while also preserving the
built-in type serialization/deserialization rules for other parameters and/or
the return value using the familiar fundamental VDF data types such as Integer,
String and Date, as well as struct types and arrays.</p>

<p>In most cases it's both easier and better to use Struct types and arrays for
working with complex data. But sometimes you just need that little extra
low-level control and flexibility over a particular parameter or return value,
and that's when XmlHandle can be useful.</p>

<p>This sample contains a Web Service to create and return a customer list as pure XML.</p>
<p>
HTML Test Page: <a href="CustomerXML.wso">CustomerXML.wso</a><br/>
WSDL: <a href="CustomerXML.wso?WSDL">CustomerXML.wso?WSDL</a>
</p>


<h4>Process Pooling and Web Services</h4>
<p>If you are running a web application that provides web services you will
want to run the application with Process Pooling enabled. When Process Pooling
is disabled, each web service request requires that a new process gets loaded,
initialized, run and then closed. When Process Pooling is enabled a web service
request can use a process that is loaded and running in a pool eliminating the
time required to load, initialize and close. This is obviously much faster.</p>

<p>You can enable or disable Process Pooling in an application by changing the
web application's properties within the Web Application Administrator Utility.</p>

<p>When process pooling is enabled, you have instances of your web application
running in a pool. Because these instances have open tables, you will not be
able to alter your tables while these processes are running. In other words, you
cannot open a table in exclusive mode within the Database Builder utility.
Trying to open the table will result in an error. If you need to change
the tables, you will need to temporarily disable the Web Application. Web
Applications can be enabled and disabled using the Web Application Administrator
Utility. Alternately, you may wish to disable process pooling during early
development process when you are still changing your tables. If you do this,
remember to turn process pooling on before deploying the application (and before
running any performance tests).</p>

<p>In this sample, Process Pooling is disabled. This is done to allow you to 
try out all of the features of Database Builder without needing to disable and 
re-enable the application. Remember that you would always want to turn process 
pooling back on before deploying an application that provides web services.</p>


<p><a href="MoreHtml.asp">More About HTML</a>&nbsp;&nbsp;&nbsp; <a href="MoreWml.asp">More
About WML</a>&nbsp;&nbsp;&nbsp; More About Web Services</p>

</body>
</html>


