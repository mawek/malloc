<html>
	<head>
		<title>smazání alokace</title>
	</head>

	<body>
		<p>
			Alokace "${allocation.name}" byla smazáná.
		</p>
			
		<p>
			Užívatel ${allocation.requester.name} ${allocation.requester.surname} si vyžádal alokaci ${allocation.hours} hodin na uživatele ${allocation.worker.name} ${allocation.worker.surname}. 
			Datum alokace:<g:formatDate date="${allocation.startDate.toDate()}" format="dd.MM.yyyy" /> <g:if test="allocation.endDate"> - <g:formatDate date="${allocation.endDate.toDate()}" format="dd.MM.yyyy" /></g:if>  				
		</p>
		
		<p>Název alokace: ${allocation.name}</p>
		<p>Popis alokace: ${allocation.description}</p>		
		
		<table>			
			<tr>
				<td>Status:</td>
				<td>
					${message(code: 'allocation.status.'+allocation.status?.encodeAsHTML(), default: allocation?.status?.encodeAsHTML())}				
				</td>
			</tr>
			<tr>
				<td>Type:</td>
				<td>
					${message(code: 'allocation.type.'+allocation.type?.encodeAsHTML(), default: allocation?.type?.encodeAsHTML())}
				</td>
			</tr>
		</table>
				
	</body>
</html>
