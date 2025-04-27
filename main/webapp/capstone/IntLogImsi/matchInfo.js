document.getElementById('file-input').addEventListener('change', function(event) {
  const file = event.target.files[0];
  if (file) {
      // 파일 이름을 표시
      document.getElementById('file-name').textContent = file.name;
      
      const reader = new FileReader();
      reader.onload = function(e) {
          const img = document.getElementById('uploaded-image');
          img.src = e.target.result;
      }
      reader.readAsDataURL(file);
  } else {
      // 파일이 선택되지 않은 경우 파일 이름 영역을 비웁니다.
      document.getElementById('file-name').textContent = '첨부파일';
  }
});