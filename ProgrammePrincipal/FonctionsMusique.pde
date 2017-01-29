void accordMajeur(Note note, boolean jeuArret) { 
  if (jeuArret) { // Si l'accord doit être joué
    myBus.sendNoteOn(note); // Jeu des 3 notes composants l'accord de la note activée
    note.pitch+=4;
    myBus.sendNoteOn(note);
    note.pitch+=3;
    myBus.sendNoteOn(note);
    note.pitch+=5;
  } else {
    myBus.sendNoteOff(note);
    note.pitch+=4;
    myBus.sendNoteOff(note);
    note.pitch+=3;
    myBus.sendNoteOff(note);
    note.pitch+=5;
  }
  note.pitch-=12;
}

void accordMineur(Note note, boolean jeuArret) {
  if (jeuArret) {
    myBus.sendNoteOn(note);
    note.pitch+=3;
    myBus.sendNoteOn(note);
    note.pitch+=4;
    myBus.sendNoteOn(note);
    note.pitch+=5;
  } else {
    myBus.sendNoteOff(note);
    note.pitch+=3;
    myBus.sendNoteOff(note);
    note.pitch+=4;
    myBus.sendNoteOff(note);
    note.pitch+=5;
  }
  note.pitch-=12;
}

void accord7(Note note, boolean jeuArret) {
  if (jeuArret) {
    myBus.sendNoteOn(note);
    note.pitch+=4;
    myBus.sendNoteOn(note);
    note.pitch+=4;
    myBus.sendNoteOn(note);
    note.pitch+=4;
  } else {
    myBus.sendNoteOff(note);
    note.pitch+=4;
    myBus.sendNoteOff(note);
    note.pitch+=4;
    myBus.sendNoteOff(note);
    note.pitch+=4;
  }
  note.pitch-=12;
}
void changerInstrument(int byteInstru ) { // Changement d'instruments : envoie d'un message MIDI au format byte
  int status_byte = 0xC0;
  int channel = 0;
  int byte2 = 0;
  myBus.sendMessage(status_byte, channel, byteInstru, byte2);
}