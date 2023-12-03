package net.codejava;

import java.util.*;

public class MainGame {

	// Array für das Board
	static String[] board;

	// Boolean für Debugnachrichten (Entwickler Hilfe)
	static boolean debug = false;

	// Public Int für die Spielerpunkte
	static int playerpoints = 0;

	// Public Int für Zugzähler
	static int turn = 0;

	// Boolean für das erreichen von 2048
	static boolean won = false;

	// String für Ende = Draw
	static String end = null;

	/*
	 * Main Methode des Spiels [ FULL KOMMENTAR ]s
	 */
	public static void main(String[] args) {
		// Adde 16 leere Stringplätze in den Array
		board = new String[16];

		// Füge in jedes Feld ein Leerzeichen ein
		for (int x = 0; x < board.length; x++) {
			board[x] = " ";
		}

		// Loope 2x und schreibe 2 random Felder mit Wert 2
		for (int i = 0; i < 2; i++) {
			int start_random = (int) Math.floor(Math.random() * 15);
			if (board[start_random] != " ")
				i--;
			board[start_random] = "2";
			debug(Integer.toString(start_random));
		}

		// Leere console und rufe printBoard Methode auf
		clearconsole();
		printboard();

		// myObj für UserInput scanner
		Scanner myObj = new Scanner(System.in);

		// Solange Public String end null ist oder open (für offener Zug möglich)
		while (end == null || end == "open") {

			// Wenn Public String end == "open" ist, melde dass noch irgendwo ein zug
			// möglich ist
			if (end == "open") {
				System.out.println("!! Es ist noch ein Zug möglich");
			}

			// Try (versuche) die Felder in die angegebene Richtung zu verschieben
			// Dannach kommt catch() falls er einen ERROR einfängt
			try {
				System.out.println("Deine Wahl:  ");
				// Benutze den Scanner um System/UserInput zu holen
				String move = myObj.nextLine();

				// Setze end auf null, um check_move message zu reseten
				end = null;

				// Switch case für userinput
				switch (move) {
				case "w":
					// Erhöhe Public Int turn um 1 (++ ist +1, -- ist -1)
					turn++;
					// Methodenaufruf für Alles hochschieben
					move_up();

					// Methodenaufruf um ein random Feld mit 0 einen Wert von 2 oder 4 spawnen
					spawn_random();

					// Leere die console
					clearconsole();

					// Zeige das neue spielbrett an
					printboard();
					break;
				case "s":
					turn++;
					move_down();
					spawn_random();
					clearconsole();
					printboard();
					break;
				case "a":
					turn++;
					move_left();
					spawn_random();
					clearconsole();
					printboard();
					break;
				case "d":
					turn++;
					move_right();
					spawn_random();
					clearconsole();
					printboard();
					break;

				default:
					// Wenn die Eingabe nicht in der Switch Index vorhanden ist, sage falsche
					// Ausgabe
					System.out.println("Falsche Angabe, bitte verwende W A S D zum spielen\nWiederholen:");
					continue;
				}

				// Catch ende für Try
			} catch (InputMismatchException e) {
				System.out.println("False Angabe #2, bitte verwende W A S D zum spielen\\nWiederholen:");
				continue;

			}
		}
		// Wenn Public String end == "draw" beende das Spiel mit einer letzten Nachricht
		// :)
		if (end == "draw") {
			System.out.println(
					"==============================================\nDanke für's Spielen, du hast leider keine weiteren Züge die du machen könntest\n\nEnde");
		}

	}

	/*
	 * Methode für altes Spielbrett hochschieben
	 */
	static void clearconsole() {
		for (int i = 0; i < 10; i++) {
			System.out.println(" ");
		}
	}

	/*
	 * Methode um das Spielbrett und Infos in der Console auszugeben [ FULL
	 * KOMMENTAR ]
	 */
	static void printboard() {
		// String für den oberen Teil des Spielbretts, leer weil alles dananch
		// hinzugefügt wird.
		String field = "";

		// ASCII Art von Zahl 2048
		String Logo = "_______________      _____   ______  \r\n" + "\\_____  \\   _  \\    /  |  | /  __  \\ \r\n"
				+ " /  ____/  /_\\  \\  /   |  |_>      < \r\n" + "/       \\  \\_/   \\/    ^   /   --   \\\r\n"
				+ "\\_______ \\_____  /\\____   |\\______  /\r\n" + "        \\/     \\/      |__|       \\/\r\n\r\n";

		// Int für die aktuelle Reihe, um Board zum Text hinzuzufügen
		int row = 0;

		// String für Info ob 2048 erreicht wurde oder nicht
		String board_won = "err";

		// Wenn Public Boolean won == false ist, sage noch nicht gewonnen
		if (won == false) {
			board_won = " Leider noch nicht, keep going ;)";

			// Falls Public Boolean won == true ist, sage gewonnen. Man kann endlos weiter
			// spielen
		} else if (won == true) {
			board_won = " ⭐ Herlichen Glückwunsch, ein Feld hat 2048 erreicht ⭐ Du bist nun im endless Modus";
		}

		// Printe die obere Hälfte des Spielbretts mit Logo, Author, Anleitung,
		// Spielerpunkte, Zug und Info ob gewonnen in der Console
		System.out.println(Logo + "  2048 Game geschrieben von: w0lFzk1nD\r\n"
				+ "Benutzung:\r\n		°  W : HOCH\r\n		°  A : LINKS\r\n		°  S : RUNTER\r\n		°  D : RECHTS\n\nPunktzahl: [ "
				+ playerpoints + " ]\nZUG:       [ " + turn + " ]\nGewonnen?  [ " + board_won + " ]\n");

		// For loop für 4 Reihen
		for (int a = 0; a < 4; a++) {
			// Das Dach :D
			field = field + "|=====|=====|=====|=====|\n";

			// For Loop für Jedes Feld
			for (int l = 0; l < 4; l++) {
				// Adde Zwischenwand und Wert des Feldes
				field = field + "| " + board[row];

				// ADDE LEERZEICHEN, wenn zahl 8, +3 leerzeichen. Wenn Zahl 16, + 2 Leerzeichen
				// um auf 4 Zeichen zu kommen
				for (int o = 0; o < 4 - board[row].length(); o++) {
					field = field + " ";
				}
				// Erhöhe den Reihenzählen um in die nächste Reihe zu gehen
				row++;
			}
			// Adde Abschlusswand und ENTER
			field = field + "|\n";
		}
		// Boden :D
		field = field + "|=====|=====|=====|=====|";
		System.out.println(field);
	}

	/*
	 * Methode für DebugTexte/Werte
	 */
	static void debug(String msg) {
		if (debug) {
			System.out.println("	#Debug# : " + msg);
			return;
		}
	}

	/*
	 * Methode für nach Unten shiften [ FULL KOMMENTAR ]
	 */
	static String move_down() {
		// Index/Position der Reihen, die zb ganz Unten liegen.
		// Da dort angefangen wird mit Check
		int[] f_rowup = { 12, 8, 4, 0 };

		// For Loop für alle 4 Reihen
		for (int u = 0; u < 4; u++) {

			// Ein Array mit 4 Int Positionen für jedes Feld der zu prüfenden Reihe
			int to_check[] = new int[4];

			// For Loop für jedes Feld
			for (int f = 0; f < 4; f++) {

				// Debugging Infos Ignorieren
				debug("Row " + u + " Field " + f + " Content ^" + board[f_rowup[f] + u] + "^ Value " + (f_rowup[f] + u)
						+ " u " + u + " f " + f);

				// Wenn Inhalt leer ist, pushe 0 in den Array fürs prüfen
				if (board[f_rowup[f] + u] == " ") {
					to_check[f] = 0;

				} else {
					// Ansonsten pushe den Wert des Feldes
					to_check[f] = Integer.parseInt(board[f_rowup[f] + u]);
				}
			}
			debug(Arrays.toString(to_check));

			// Int um die Summe der ganzen Reihe zu errechnen
			int sum = 0;

			// For Loop um alle 4 werte des Arrays/der Reihe zusammenzurechnen
			for (int s = 0; s < 4; s++) {
				sum += to_check[s];
			}

			// Wenn Wert 0 ist, skippe hier weil nix zu tun, kein Feld hat einen Wert
			if (sum != 0) {

				// For Loop für jedes Feld, jedoch starte bei Feld 1, nicht 0, weil 0 nicht
				// bewegt werden muss.
				for (int i = 1; i < to_check.length; i++) {

					// Switch Case für i, also position des feldes. 1, 2, 3
					switch (i) {
					// Wenn i = 1 ist, bearbeite Position 1
					case 1:
						// Wenn Wert an Position 0, der Wert 0 ist
						if (to_check[i - 1] == 0) {

							// Setze Wert von Feld 1, auf Position 0
							to_check[i - 1] = to_check[i];

							// Und ersetze Position 1 mit 0
							to_check[i] = 0;

							// Wenn Wert an erster Stelle gleich ist wie zweites Feld
						} else if (to_check[i - 1] == to_check[i]) {

							// Int für das Ergebnis der Addition der Werte
							int toadd = to_check[i] + to_check[i - 1];

							// Wenn Wert == 2048, setze Public Boolean won auf true
							if (toadd == 2048) {
								won = true;
							}

							// Setze Position 0 auf Ergebnis der beiden Werte
							to_check[i - 1] = toadd;

							// Adde den Wert zu den Spielerpunkten
							playerpoints += toadd;

							// Setze Position 1 auf Wert 0
							to_check[i] = 0;
						}
						break;

					// Wenn i = 2, bearbeite Position 2
					case 2:

						// Wenn Position 1 Wert 0 hat
						if (to_check[i - 1] == 0) {

							// Und wenn auch Position 0 Wert 0 hat
							if (to_check[i - 2] == 0) {

								// Schiebe den Wert des Feldes auf Position 0
								to_check[i - 2] = to_check[i];

								// Setze Position 2 auf Wert 0
								to_check[i] = 0;

								// Wenn Psotion 0 nicht Wert 0 hat, aber den gleichen wie Position 2
							} else if (to_check[i - 2] == to_check[i]) {

								// Int für den wert der addition
								int toadd = to_check[i] + to_check[i - 2];

								// Wenn Wert gleich 2048 ist setze Public Boolean won auf true
								if (toadd == 2048) {
									won = true;
								}

								// Ersetze Position 0 mit Wert der Addition von Position 0 und 2
								to_check[i - 2] = toadd;

								// Addiere Wert zu den Spielerpunkten
								playerpoints += toadd;

								// Setze Position 2 auf Wert 0
								to_check[i] = 0;

								// Ansonsten setze Wert von Position 1 auf Wert von Position 2,
								// Da Position 1 ja Wert 0 hat
							} else {
								to_check[i - 1] = to_check[i];
								to_check[i] = 0;
							}

							// Wenn Position 1 nicht Wert 0 hat und der selbe ist wie Position 2
						} else if (to_check[i - 1] == to_check[i]) {

							// Int für den Wert der Addition
							int toadd = to_check[i] + to_check[i - 1];

							// Wenn Wert gleich 2048 ist, setze Public Boolean won auf true
							if (toadd == 2048) {
								won = true;
							}

							// Setze Position 1 auf Wert der addition
							to_check[i - 1] = toadd;

							// Addiere den Wert zu den Spielerpunkten
							playerpoints += toadd;

							// Setze Position 2 Wert auf 0
							to_check[i] = 0;
						}
						break;

					// Wiederhole das für Position 3 des Arrays....
					case 3:

						if (to_check[i - 1] == 0) {
							if (to_check[i - 2] == 0) {
								if (to_check[i - 3] == 0) {
									to_check[i - 3] = to_check[i];
									to_check[i] = 0;
								} else if (to_check[i - 3] == to_check[i]) {
									int toadd = to_check[i] + to_check[i - 3];
									if (toadd == 2048) {
										won = true;
									}
									to_check[i - 3] = toadd;
									playerpoints += toadd;
									to_check[i] = 0;
								} else {
									to_check[i - 2] = to_check[i];
									to_check[i] = 0;
								}
							} else if (to_check[i - 2] == to_check[i]) {
								int toadd = to_check[i] + to_check[i - 2];
								if (toadd == 2048) {
									won = true;
								}
								to_check[i - 2] = toadd;
								playerpoints += toadd;
								to_check[i] = 0;
							} else {
								to_check[i - 1] = to_check[i];
								to_check[i] = 0;
							}
						} else if (to_check[i - 1] == to_check[i]) {
							int toadd = to_check[i] + to_check[i - 1];
							if (toadd == 2048) {
								won = true;
							}
							to_check[i - 1] = toadd;
							playerpoints += toadd;
							to_check[i] = 0;
						}
						break;

					}
				}
			}
			debug(Arrays.toString(to_check));

			// For Loop für jedes Feld des Zwischen Arrays
			for (int upd = 0; upd < 4; upd++) {

				// Wenn der Wert des Feldes 0 ist, pushe ein Leerzeichen in das eigentliche
				// Board an dieser Stelle
				if (to_check[upd] == 0) {
					board[f_rowup[upd] + u] = " ";

				} else {
					// Ansonsten Schiebe den Wert des Feldes in das eigentliche Board an dieser
					// Stelle
					board[f_rowup[upd] + u] = Integer.toString(to_check[upd]);
				}
			}
			debug(Arrays.toString(board));
		}
		return null;
	}

	/*
	 * Methode für nach Oben shiften
	 */
	static String move_up() {
		int[] f_rowup = { 0, 4, 8, 12 };
		for (int u = 0; u < 4; u++) {
			int to_check[] = new int[4];
			for (int f = 0; f < 4; f++) {
				debug("Row " + u + " Field " + f + " Content ^" + board[f_rowup[f] + u] + "^ Value " + (f_rowup[f] + u)
						+ " u " + u + " f " + f);
				if (board[f_rowup[f] + u] == " ") {
					to_check[f] = 0;
				} else {
					to_check[f] = Integer.parseInt(board[f_rowup[f] + u]);
				}
			}
			debug(Arrays.toString(to_check));
			int sum = 0;
			for (int s = 0; s < 4; s++) {
				sum += to_check[s];
			}

			if (sum != 0) {
				for (int i = 1; i < to_check.length; i++) {
					switch (i) {
					case 1:
						if (to_check[i - 1] == 0) {
							to_check[i - 1] = to_check[i];
							to_check[i] = 0;
						} else if (to_check[i - 1] == to_check[i]) {
							int toadd = to_check[i] + to_check[i - 1];
							if (toadd == 2048) {
								won = true;
							}
							to_check[i - 1] = toadd;
							playerpoints += toadd;
							to_check[i] = 0;
						}
						break;

					case 2:
						if (to_check[i - 1] == 0) {
							if (to_check[i - 2] == 0) {
								to_check[i - 2] = to_check[i];
								to_check[i] = 0;
							} else if (to_check[i - 2] == to_check[i]) {
								int toadd = to_check[i] + to_check[i - 2];
								if (toadd == 2048) {
									won = true;
								}
								to_check[i - 2] = toadd;
								playerpoints += toadd;
								to_check[i] = 0;
							} else {
								to_check[i - 1] = to_check[i];
								to_check[i] = 0;
							}
						} else if (to_check[i - 1] == to_check[i]) {
							int toadd = to_check[i] + to_check[i - 1];
							if (toadd == 2048) {
								won = true;
							}
							to_check[i - 1] = toadd;
							playerpoints += toadd;
							to_check[i] = 0;
						}
						break;

					case 3:

						if (to_check[i - 1] == 0) {
							if (to_check[i - 2] == 0) {
								if (to_check[i - 3] == 0) {
									to_check[i - 3] = to_check[i];
									to_check[i] = 0;
								} else if (to_check[i - 3] == to_check[i]) {
									int toadd = to_check[i] + to_check[i - 3];
									if (toadd == 2048) {
										won = true;
									}
									to_check[i - 3] = toadd;
									playerpoints += toadd;
									to_check[i] = 0;
								} else {
									to_check[i - 2] = to_check[i];
									to_check[i] = 0;
								}
							} else if (to_check[i - 2] == to_check[i]) {
								int toadd = to_check[i] + to_check[i - 2];
								if (toadd == 2048) {
									won = true;
								}
								to_check[i - 2] = toadd;
								playerpoints += toadd;
								to_check[i] = 0;
							} else {
								to_check[i - 1] = to_check[i];
								to_check[i] = 0;
							}
						} else if (to_check[i - 1] == to_check[i]) {
							int toadd = to_check[i] + to_check[i - 1];
							if (toadd == 2048) {
								won = true;
							}
							to_check[i - 1] = toadd;
							playerpoints += toadd;
							to_check[i] = 0;
						}
						break;
					}
				}
			}

			debug(Arrays.toString(to_check));
			for (int upd = 0; upd < 4; upd++) {
				if (to_check[upd] == 0) {
					board[f_rowup[upd] + u] = " ";
				} else {
					board[f_rowup[upd] + u] = Integer.toString(to_check[upd]);
				}
			}
			debug(Arrays.toString(board));
		}
		return null;
	}

	/*
	 * Methode für nach Rechts shiften
	 */
	static String move_right() {
		int[] f_rowup = { 3, 2, 1, 0 };
		int bigcounter = 0;
		//
		for (int u = 0; u < 4; u++) {
			int to_check[] = new int[4];
			for (int f = 0; f < 4; f++) {
				debug("Row u: " + u + " Field f:" + f + " Content: ^" + board[f_rowup[f] + bigcounter] + "^ Value: "
						+ (f_rowup[f] + bigcounter) + " u + bigcounter:" + (u + bigcounter));
				if (board[f_rowup[f] + bigcounter] == " ") {
					to_check[f] = 0;
				} else {
					to_check[f] = Integer.parseInt(board[f_rowup[f] + bigcounter]);
				}
			}
			debug(Arrays.toString(to_check));

			int sum = 0;
			for (int s = 0; s < 4; s++) {
				sum += to_check[s];
			}

			if (sum != 0) {
				for (int i = 1; i < to_check.length; i++) {
					switch (i) {
					case 1:
						if (to_check[i - 1] == 0) {
							to_check[i - 1] = to_check[i];
							to_check[i] = 0;
						} else if (to_check[i - 1] == to_check[i]) {
							int toadd = to_check[i] + to_check[i - 1];
							if (toadd == 2048) {
								won = true;
							}
							to_check[i - 1] = toadd;
							playerpoints += toadd;
							to_check[i] = 0;
						}
						break;

					case 2:
						if (to_check[i - 1] == 0) {
							if (to_check[i - 2] == 0) {
								to_check[i - 2] = to_check[i];
								to_check[i] = 0;
							} else if (to_check[i - 2] == to_check[i]) {
								int toadd = to_check[i] + to_check[i - 2];
								if (toadd == 2048) {
									won = true;
								}
								to_check[i - 2] = toadd;
								playerpoints += toadd;
								to_check[i] = 0;
							} else {
								to_check[i - 1] = to_check[i];
								to_check[i] = 0;
							}
						} else if (to_check[i - 1] == to_check[i]) {
							int toadd = to_check[i] + to_check[i - 1];
							if (toadd == 2048) {
								won = true;
							}
							to_check[i - 1] = toadd;
							playerpoints += toadd;
							to_check[i] = 0;
						}
						break;

					case 3:

						if (to_check[i - 1] == 0) {
							if (to_check[i - 2] == 0) {
								if (to_check[i - 3] == 0) {
									to_check[i - 3] = to_check[i];
									to_check[i] = 0;
								} else if (to_check[i - 3] == to_check[i]) {
									int toadd = to_check[i] + to_check[i - 3];
									if (toadd == 2048) {
										won = true;
									}
									to_check[i - 3] = toadd;
									playerpoints += toadd;
									to_check[i] = 0;
								} else {
									to_check[i - 2] = to_check[i];
									to_check[i] = 0;
								}
							} else if (to_check[i - 2] == to_check[i]) {
								int toadd = to_check[i] + to_check[i - 2];
								if (toadd == 2048) {
									won = true;
								}
								to_check[i - 2] = toadd;
								playerpoints += toadd;
								to_check[i] = 0;
							} else {
								to_check[i - 1] = to_check[i];
								to_check[i] = 0;
							}
						} else if (to_check[i - 1] == to_check[i]) {
							int toadd = to_check[i] + to_check[i - 1];
							if (toadd == 2048) {
								won = true;
							}
							to_check[i - 1] = toadd;
							playerpoints += toadd;
							to_check[i] = 0;
						}
						break;
					}
				}
			}

			debug(Arrays.toString(to_check));
			for (int upd = 0; upd < 4; upd++) {
				if (to_check[upd] == 0) {
					board[f_rowup[upd] + bigcounter] = " ";
				} else {
					board[f_rowup[upd] + bigcounter] = Integer.toString(to_check[upd]);
				}
			}
			debug(Arrays.toString(board));
			bigcounter += 4;
		}
		return null;
	}

	/*
	 * Methode für nach Links shiften
	 */
	static String move_left() {
		int[] f_rowup = { 0, 1, 2, 3 };
		int bigcounter = 0;
		//
		for (int u = 0; u < 4; u++) {
			int to_check[] = new int[4];
			for (int f = 0; f < 4; f++) {
				debug("Row u:" + u + " Field f:" + f + " Content ^" + board[f_rowup[f] + bigcounter] + "^ Value "
						+ (f_rowup[f] + bigcounter) + " bigcounter: " + bigcounter);
				if (board[f_rowup[f] + bigcounter] == " ") {
					to_check[f] = 0;
				} else {
					to_check[f] = Integer.parseInt(board[f_rowup[f] + bigcounter]);
				}
			}
			debug(Arrays.toString(to_check));

			int sum = 0;
			for (int s = 0; s < 4; s++) {
				sum += to_check[s];
			}

			if (sum != 0) {
				for (int i = 1; i < to_check.length; i++) {
					switch (i) {
					case 1:
						if (to_check[i - 1] == 0) {
							to_check[i - 1] = to_check[i];
							to_check[i] = 0;
						} else if (to_check[i - 1] == to_check[i]) {
							int toadd = to_check[i] + to_check[i - 1];
							if (toadd == 2048) {
								won = true;
							}
							to_check[i - 1] = toadd;
							playerpoints += toadd;
							to_check[i] = 0;
						}
						break;

					case 2:
						if (to_check[i - 1] == 0) {
							if (to_check[i - 2] == 0) {
								to_check[i - 2] = to_check[i];
								to_check[i] = 0;
							} else if (to_check[i - 2] == to_check[i]) {
								int toadd = to_check[i] + to_check[i - 2];
								if (toadd == 2048) {
									won = true;
								}
								to_check[i - 2] = toadd;
								playerpoints += toadd;
								to_check[i] = 0;
							} else {
								to_check[i - 1] = to_check[i];
								to_check[i] = 0;
							}
						} else if (to_check[i - 1] == to_check[i]) {
							int toadd = to_check[i] + to_check[i - 1];
							if (toadd == 2048) {
								won = true;
							}
							to_check[i - 1] = toadd;
							playerpoints += toadd;
							to_check[i] = 0;
						}
						break;

					case 3:

						if (to_check[i - 1] == 0) {
							if (to_check[i - 2] == 0) {
								if (to_check[i - 3] == 0) {
									to_check[i - 3] = to_check[i];
									to_check[i] = 0;
								} else if (to_check[i - 3] == to_check[i]) {
									int toadd = to_check[i] + to_check[i - 3];
									if (toadd == 2048) {
										won = true;
									}
									to_check[i - 3] = toadd;
									playerpoints += toadd;
									to_check[i] = 0;
								} else {
									to_check[i - 2] = to_check[i];
									to_check[i] = 0;
								}
							} else if (to_check[i - 2] == to_check[i]) {
								int toadd = to_check[i] + to_check[i - 2];
								if (toadd == 2048) {
									won = true;
								}
								to_check[i - 2] = toadd;
								playerpoints += toadd;
								to_check[i] = 0;
							} else {
								to_check[i - 1] = to_check[i];
								to_check[i] = 0;
							}
						} else if (to_check[i - 1] == to_check[i]) {
							int toadd = to_check[i] + to_check[i - 1];
							if (toadd == 2048) {
								won = true;
							}
							to_check[i - 1] = toadd;
							playerpoints += toadd;
							to_check[i] = 0;
						}
						break;
					}
				}
			}

			debug(Arrays.toString(to_check));
			for (int upd = 0; upd < 4; upd++) {
				if (to_check[upd] == 0) {
					board[f_rowup[upd] + bigcounter] = " ";
				} else {
					board[f_rowup[upd] + bigcounter] = Integer.toString(to_check[upd]);
				}
			}
			debug(Arrays.toString(board));
			bigcounter += 4;
		}
		return null;
	}

	/*
	 * Methode für neue Zahl auf zufälligem freien feld [ FULL KOMMENTAR ]
	 */
	static void spawn_random() {

		// Boolean ob ein Feld gespawnt wurde
		boolean spawned = false;

		// Array mit den Werten die gespawnt werden können
		String[] numbers = { "2", "4" };

		// Int für eine Random Zahl zwischen 1 und der Anzahl der Objekte in Array
		// numbers
		int random_val = (int) Math.floor(Math.random() * numbers.length);

		// Array ohne Längenbegrenzung, um Positionen zu speichern, die nicht wert 0
		// haben
		ArrayList<String> used = new ArrayList<String>();

		// While Loop, solange Boolean spawned false ist
		while (!spawned) {

			// Int für Random Zahl zwischen 0 und 15
			int spawn_random = (int) Math.floor(Math.random() * 15);

			// If Statement, wenn Wert des Boards an der gezogenen spawn_random Stelle 0
			// (Leerzeichen) ist
			if (board[spawn_random] == " ") {

				// Setze den Wert, der weiter oben gezogenen Random Zahl in das random Feld
				board[spawn_random] = numbers[random_val];

				// Setze spawned auf true und beende while loop
				spawned = true;

				// Wenn das Feld nicht Wert 0 (Leerzeichen) hat
			} else {

				// Wenn der Array used, die random Zahl noch nicht beihält
				if (!used.contains(Integer.toString(spawn_random))) {

					// Adde die random Zahl in den Array used und fange von vorne an
					used.add(Integer.toString(spawn_random));

					// Wenn der used Array 15 Items hat
				} else if (used.toArray().length == 15) {

					// String mit resultat der checkmove methode
					String ch_move = checkmove();

					// Wenn resultat gleich null ist, ist unentschieden
					if (ch_move == null) {

						// Setze Public String end auf draw um Spiel zu beenden
						end = "draw";

						// Setze Spawned auf true um den while loop zu beenden
						spawned = true;

						// Wenn resultat gleich "turn" ist
					} else if (ch_move == "turn") {

						// Setze Spawned auf true um den while loop zu beenden
						spawned = true;

						// Setze Public String end auf open, damit die Nachricht kommt
						// Dass noch wo anderes ein Zug offen ist
						end = "open";
					}
				}
			}
		}
	}

	/*
	 * Methode um zu checken, ob ein Zug möglich wäre
	 * 
	 * Mal sehen wer nun in der Lage ist, diesen unteren Teil einigermassen zu
	 * verstehen :3
	 */
	static String checkmove() {
		int[] check_up = { 0, 4, 8, 12 };
		int[] check_down = { 12, 8, 4, 0 };
		int[] check_left = { 0, 1, 2, 3 };
		int[] check_right = { 3, 2, 1, 0 };
		for (int c = 0; c < 4; c++) {
			int[] check = null;
			int bigcounter = 0;
			int counter = 0;
			if (c == 0) {
				check = check_up;
				counter = 1;
			} else if (c == 1) {
				check = check_down;
				counter = 1;
			} else if (c == 2) {
				check = check_left;
				counter = 4;
			} else if (c == 3) {
				check = check_right;
				counter = 4;
			}
			for (int u = 0; u < 4; u++) {
				int to_check[] = new int[4];
				for (int f = 0; f < 4; f++) {
					if (board[check[f] + bigcounter] == " ") {
						to_check[f] = 0;
					} else {
						to_check[f] = Integer.parseInt(board[check[f] + bigcounter]);
					}
				}
				for (int i = 1; i < to_check.length; i++) {
					switch (i) {
					case 1:
						if (to_check[i - 1] == to_check[i]) {
							return "turn";
						}
						break;

					case 2:
						if (to_check[i - 1] == 0) {
							if (to_check[i - 2] == to_check[i]) {
								return "turn";
							}
						} else if (to_check[i - 1] == to_check[i]) {
							return "turn";
						}
						break;

					case 3:

						if (to_check[i - 1] == 0) {
							if (to_check[i - 2] == 0) {
								if (to_check[i - 3] == to_check[i]) {
									return "turn";
								}
							} else if (to_check[i - 2] == to_check[i]) {
								return "turn";
							}
						} else if (to_check[i - 1] == to_check[i]) {
							return "turn";
						}
						break;
					}
				}
			}
			bigcounter += counter;
		}
		return null;
	}
}