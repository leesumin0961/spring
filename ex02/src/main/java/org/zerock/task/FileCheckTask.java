package org.zerock.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {

	
	@Setter(onMethod_ = { @Autowired })
	private BoardAttachMapper attachMapper;

	private String getFolderYesterDay() {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Calendar cal = Calendar.getInstance();

		cal.add(Calendar.DATE, -1);

		String str = sdf.format(cal.getTime());
		log.info("=======어제날짜=======-:"+ str.replace("-",File.separator));
		return str.replace("-", File.separator);
	}


	@Scheduled(cron="0 0 2 * * *")
	public void checkFiles()throws Exception{
		log.warn("File Check Task run.........");
		log.warn("===============================");
		
		//어제 업로드된 첨부파일 목록구하기
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();
		
		//어제 업로드된 첨부파일 목록으로 파일경로 구함
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get("C:\\upload",vo.getUploadPath(),vo.getUuid()+ "_" +vo.getFileName()))
				.collect(Collectors.toList());
		
		//이미지파일의 경우는 섬네일 팡일경로 구함
		fileList.stream().filter(vo -> vo.isFileType() == true)
		.map(vo ->Paths.get("C:\\upload",vo.getUploadPath(),"s_" + vo.getUuid() + "_"+ vo.getFileName()))
		.forEach(p -> fileListPaths.add(p));
		
		log.warn("===========================================");
		
		fileListPaths.forEach(p -> log.warn(p));
		
		//어제 디렉토리 경로
		File targetDir = Paths.get("C:\\upload",getFolderYesterDay()).toFile();
		
		//어제디록토리와 비교해서 삭제할 파일 경로 구하기
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		log.warn("=============================================");
		//하나씩 삭제
		for(File file:removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
}
