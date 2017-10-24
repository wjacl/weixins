<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Include Editor JS files. -->
<script type="text/javascript" src="${ctx }/js/froala-editor/js/froala_editor.min.js"></script>
<script type="text/javascript" src="${ctx }/js/froala-editor/js/froala_editor.pkgd.min.js"></script>
<script type="text/javascript" src="${ctx }/js/froala-editor/js/languages/zh_cn.js"></script>
<script type="text/javascript" src="${ctx }/js/froala-editor/js/plugins/align.min.js"></script>
<script type="text/javascript" src="${ctx }/js/froala-editor/js/plugins/image.min.js"></script>
<script type="text/javascript" src="${ctx }/js/froala-editor/js/plugins/image_manager.min.js"></script>
<script type="text/javascript" src="${ctx }/js/froala-editor/js/plugins/link.min.js"></script>

<!-- Initialize the editor. -->
<script> 
	function h5FichEditorInit(id,imageUploadUrl,params){
		$('#' + id).froalaEditor({
			language: 'zh_cn',
		    toolbarButtonsXS: ['bold', 'italic', 'underline', 'fontSize', 'insertImage','align','undo', 'redo'],
		    imageUploadURL: imageUploadUrl,
		    imageUploadParams : params != undefined ? params : {}});
	}
	
	function h5FichEditorAuthInroInit(id){
		h5FichEditorInit(id,publicUploadUrl,{type:"intro"});
	}
	function h5FichEditorBrandInit(id){
		h5FichEditorInit(id,publicUploadUrl,{type:"brand"});
	}
	function h5FichEditorCommonInit(id){
		h5FichEditorInit(id,publicUploadUrl);
	} 
	
    window.onload=function(){
	    var temp = document.getElementsByTagName("a");
	    var i = 0;
	    for(i=0;i<temp.length;i++){
	        //console.log(temp[i].href);
	        if(temp[i].href=="https://www.froala.com/wysiwyg-editor?k=u")
	        {           
	        	temp[i].parentNode.removeChild(temp[i].parentNode.childNodes[0]);
	        }
	    }
	}
</script>