<html>
	<head>
		<title>odmítnutí alokace</title>
	</head>

	<body>
		<p>
			Alokace "${allocation.name}" byla odmítnuta.				
		</p>
		<p>
			<g:createLink absolute="true" action="show" controller="allocation" params="${[id:allocation.id]}"></g:createLink>
		</p>		
						
	</body>
</html>
