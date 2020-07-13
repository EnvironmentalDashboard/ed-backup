document.getElementById('schedule').onclick = () => {
  const xhr = new XMLHttpRequest();

  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4) {
      window.location.reload();
    }
  }

  xhr.open('POST', '/schedule', true);
  xhr.send();
};
