const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const fs = require('fs');
const fastcsv = require('fast-csv');

const app = express();
const PORT = 3000;

mongoose.connect('mongodb://127.0.0.1:27017/attendence_hacktu', { useNewUrlParser: true, useUnifiedTopology: true });
const db = mongoose.connection;

db.on('error', console.error.bind(console, 'MongoDB connection error:'));
db.once('open', () => {
  console.log('Connected to MongoDB');
});

const studentSchema = new mongoose.Schema({
  name: String,
  email: String,
  gender: String,
  phone: String,
  hostel: String,
  teamName: String,
  rollNo: String,
  teamID: String,
  attendance: Boolean,
});

const Student = mongoose.model('Student', studentSchema);

app.use(bodyParser.json());

app.post('/addStudent', async (req, res) => {
    try {
      const newStudent = new Student({ ...req.body, attendance: false }); 
      const savedStudent = await newStudent.save();
      res.json(savedStudent);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });
  

app.post('/updateStudent', async (req, res) => {
    try {
      const { rollNo, updatedField, updatedValue } = req.body;
  
      if (!rollNo || !updatedField || updatedValue === undefined) {
        return res.status(400).json({ error: 'Invalid request. Provide rollNo, updatedField, and updatedValue.' });
      }
  
      const updateQuery = { [updatedField]: updatedValue };
  
      const updatedStudent = await Student.findOneAndUpdate(
        { rollNo: rollNo },
        updateQuery,
        { new: true }
      );
  
      if (!updatedStudent) {
        return res.status(404).json({ error: 'Student not found' });
      }
  
      res.json(updatedStudent);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });
  
  
  app.post('/fetchStudent', async (req, res) => {
    try {
      const { rollNo } = req.body;
  
      const student = await Student.findOne({ rollNo });
  
      if (!student) {
        return res.status(404).json({ error: 'Student not found' });
      }
  
      res.json(student);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });
  
  app.get('/downloadCSV', async (req, res) => {
    try {
      const students = await Student.find();
  
      if (students.length === 0) {
        return res.status(404).json({ error: 'No students found' });
      }
  
      const csvStream = fastcsv.format({ headers: true });
      const writableStream = fs.createWriteStream('students.csv');
  
      csvStream.pipe(writableStream);
  
      students.forEach((student) => {
        csvStream.write({
          name: student.name,
          email: student.email,
          gender: student.gender,
          phone: student.phone,
          hostel: student.hostel,
          teamName: student.teamName,
          rollNo: student.rollNo,
          teamID: student.teamID,
          attendance: student.attendance,
        });
      });
  
      csvStream.end();
  
      res.setHeader('Content-Disposition', 'attachment; filename=students.csv');
      res.setHeader('Content-Type', 'text/csv');
  
      fs.createReadStream('students.csv').pipe(res);
  
      writableStream.on('finish', () => {
        fs.unlinkSync('students.csv');
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
