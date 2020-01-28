<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>upload with ajax</h1>

<style>
.uploadResult {
	width: 100%;
	background: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}

.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:600px;
  height:600px;
  background-color: gray; 
  z-index: 100;
}

.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
.bigPicture img{
	width:600px;
}

</style>

<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>


	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<button id="uploadBtn">Upload</button>
	<div class="uploadResult">
		<ul></ul>

	</div>



	<script src="https://code.jquery.com/jquery-3.3.1.min.js">
		
	</script>
	<script>
	
	function showImage(fileCallPath){
		  
		  //alert(fileCallPath);
		
		  $(".bigPictureWrapper").css("display","flex").show();
		  
		  $(".bigPicture")
		  .html("<img src='/display?fileName="+ encodeURI(fileCallPath)+"'>")
		  .animate({width:'100%', height: '100%'}, 1000);

		}
		
		$(document).ready(function() {
			//업로드파일 확장자 필터링
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");//정규식
			var maxSize = 5242880;//5MB

			function checkExtension(fileName, fileSize) {
				if (fileSize >= maxSize) {
					alert("초과");
					return false;
				}
				if (regex.test(fileName)) {
					alert("없음")
					return false;
				}
				return true;
			}

			var uploadResult = $(".uploadResult ul");//업로드결과 출력영역
			function showUploadedFile(uploadResultArr) {
				var str = "";
				
				$(uploadResultArr).each(function(i, obj) {
					
					//이미지파일이 아닌경우
				if (!obj.image) {
					var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
					
				     str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+
			           "<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+
			           "<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>"+
			           "<div></li>"
			           
						}else{
							//str += "<li>" + obj.fileName + "</li>";
							   var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
						       var originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;
						       originPath = originPath.replace(new RegExp(/\\/g),"/");
												        
						       str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
					              "<img src='display?fileName="+fileCallPath+"'></a>"+
					              "<span data-file=\'"+fileCallPath+"\' data-type='image'> x </span>"+
					              "<li>";
						}
				});
				uploadResult.append(str);
			}
			
			$(".uploadResult").on("click","span",function(e){
				
				var targetFile =$(this).data("file");
				var type = $(this).data("type");
				console.log(targetFile)
				
				$.ajax({
					url:'/deleteFile',
					data:{fileName:targetFile,type:type},
					dataType:'text',
					type:'POST',
					success:function(result){
						alert(result);
					}
				});
			});
			
			
			$(".bigPictureWrapper").on("click", function(e){
				  $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
					  setTimeout(function() {
					  $(".bigPictureWrapper").hide();
				  }, 1000);
				  
				});
			
			

			var cloneObj = $(".uploadDiv").clone();//복제

			$("#uploadBtn").on("click", function(e) {

				var formData = new FormData();
				var inputFile = $("input[name='uploadFile']");
				var files = inputFile[0].files;

				console.log(files);

				//add filedate to formdata
				for (var i = 0; i < files.length; i++) {
					if (!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					formData.append("uploadFile", files[i]);
				}

				$.ajax({
					url : '/uploadAjaxAction',
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					dataType : 'json',
					success : function(result) {
						console.log(result);

						//업로드파일 리스트출력
						showUploadedFile(result);

						//input type='file'초기화
						$(".uploadDiv").html(cloneObj.html());

					}
				});
			});
		});
	</script>
</body>
</html>