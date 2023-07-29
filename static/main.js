const fragment = new DocumentFragment();
const api = 'http://localhost:3000/api/tests'

function findData(url) {  
  fetch(url).
    then((response) => response.json()).
    then((data) => {
      data.forEach(function(exam) {
        const tr = document.createElement('tr');
        values = Object.values(exam);
        values.shift();
        values.forEach(value => {
          const tb = document.createElement('td');
          tb.textContent = `${value}`;
          tr.appendChild(tb);
        });
        fragment.appendChild(tr);
      })
    }).
    then(() => {
      document.querySelector('tbody').appendChild(fragment);
    }).
    catch(function(error) {
      console.log(error);
    });
}

findData(api);

function searchToken() {
  input = document.querySelector('input#token-input');
  document.querySelector('tbody').innerHTML = '';
  findData(`${api}/${input.value}`);
}

function backHome() {
  document.querySelector('tbody').innerHTML = '';
  findData(api);
}

function leaveLoading() {
  window.location.href = 'http://localhost:3000';
}