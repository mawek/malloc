<html>
	<head>
		<title>odmítnutí alokace</title>
	</head>

	<body>
		<p>
			Alokace "${allocation.name}" byla odmítnuta.				
		</p>
		<p>			
			<g:link absolute="true" action="show" controller="allocation" params="${[id:newAllocation.id]}"><g:message code="allocation.link"/></g:link>
		</p>		
						
	</body>
</html>
