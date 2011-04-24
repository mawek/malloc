<html>
	<head>
		<title>nová alokace</title>
	</head>

	<body>
		<p>
			Užívatel ${allocation.requester.name} ${allocation.requester.surname} si vyžádal alokaci ${allocation.hours} hodin na uživatele ${allocation.worker.name} ${allocation.worker.surname}. 
			Datum alokace:<g:formatDate date="${allocation.startDate.toDate()}" format="dd.MM.yyyy" /> <g:if test="allocation.endDate"> - <g:formatDate date="${allocation.endDate.toDate()}" format="dd.MM.yyyy" /></g:if>   
			<g:if test="allocation.approver">Alokaci jěště musí schválit užívatel ${allocation.approver.name} ${allocation.approver.surname}.</g:if>	
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
				
		<p>			
			<g:link absolute="true" action="show" controller="allocation" params="${[id:newAllocation.id]}"><g:message code="allocation.link"/></g:link>
		</p>
				
	</body>
</html>
