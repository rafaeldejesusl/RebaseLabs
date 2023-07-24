const fragment = new DocumentFragment();
const api = 'http://localhost:3000/tests'

fetch(api).
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