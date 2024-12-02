window.addEventListener("load", function () {
  // Process .question elements to add corresponding inputs
  const questions = document.getElementsByClassName("question");
  for (const [index, element] of Array.from(questions).entries()) {
    const ansElem = document.createElement("textarea");
    ansElem.setAttribute("id", "question" + (index + 1));
    ansElem.setAttribute("placeholder", "Type your answer here...");
    ansElem.classList.add("input-box");
    element.insertAdjacentElement("afterend", ansElem);

    ansElem.addEventListener("input", function () {
      this.style.height = "auto";
      this.style.height = this.scrollHeight + "px";
      saveAnswers(); // Save textarea answers on input
    });
  }

  // Save answers on table inputs
  const tableInputs = document.querySelectorAll("table input[type='text']");
  tableInputs.forEach((input) => {
    input.addEventListener("input", saveAnswers);
  });

  // Load previously saved answers
  loadAnswers();
});

// Function to save all answers (textarea and table inputs)
function saveAnswers() {
  // Save textareas
  const textareas = document.querySelectorAll('textarea[id^="question"]');
  textareas.forEach((textarea) => {
    const answer = textarea.value || "";
    localStorage.setItem(textarea.id, answer);
  });

  // Save table inputs
  const tableInputs = document.querySelectorAll("table input[type='text']");
  tableInputs.forEach((input) => {
    const answer = input.value || "";
    const inputId =
      input.id || `table-input-${Array.from(tableInputs).indexOf(input)}`;
    localStorage.setItem(inputId, answer);
  });

  console.log("Answers saved to local storage.");
}

// Function to load saved answers
function loadAnswers() {
  // Load textareas
  const textareas = document.querySelectorAll('textarea[id^="question"]');
  textareas.forEach((textarea) => {
    const savedAnswer = localStorage.getItem(textarea.id) || "";
    textarea.value = savedAnswer;
  });

  // Load table inputs
  const tableInputs = document.querySelectorAll("table input[type='text']");
  tableInputs.forEach((input) => {
    const inputId =
      input.id || `table-input-${Array.from(tableInputs).indexOf(input)}`;
    const savedAnswer = localStorage.getItem(inputId) || "";
    input.value = savedAnswer;
  });

  console.log("Answers loaded from local storage.");
}

// Function to download the answers as a PDF
document.getElementById("downloadBtn").addEventListener("click", function () {
  const questions = document.querySelectorAll(".question");
  let answersHTML = `
    <div style="font-family: Arial, sans-serif; padding: 20px;">
      <h1 style="text-align: center; font-size: 24px;">Assignment Submission</h1>
      <h2 style="font-size: 18px;">Submitter</h2>
      <table>`;

  // Include table data
  const table = document.querySelector("table.personal-details");
  for (let i = 0, row; (row = table.rows[i]); i++) {
    answersHTML += `<tr><td style="font-weight: bold;">${row.cells[0].textContent}</td><td>${row.cells[1].children[0].value}</td></tr>`;
  }
  answersHTML += `</table>`;

  questions.forEach((question, index) => {
    const questionNumber = index + 1;
    const questionText = question.innerHTML;
    const answerText =
      document.getElementById(`question${questionNumber}`).value;

    answersHTML += `
      <h2 style="font-size: 18px; margin-bottom: 5px;">${questionText}</h2>
      <p style="font-size: 14px;">${answerText || "No answer provided"}</p>
    `;
  });

  answersHTML += `</div>`;

  const opt = {
    margin: 1,
    filename: "assignment_answers.pdf",
    image: { type: "jpeg", quality: 0.98 },
    html2canvas: { scale: 2 },
    jsPDF: { unit: "in", format: "letter", orientation: "portrait" },
  };

  html2pdf().from(answersHTML).set(opt).save();
});
