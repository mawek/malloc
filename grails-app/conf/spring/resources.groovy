// Place your Spring DSL code here
beans = {
	multipartResolverBean(org.springframework.web.multipart.commons.CommonsMultipartResolver){ 
		maxUploadSize=1000000 
	}
}
