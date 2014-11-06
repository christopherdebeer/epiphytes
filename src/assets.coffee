module.exports = RT023_ASSETS =
  nosuchstateasset:
    text: """
      ERROR! Status: 4. 0. 4.
      To return to the main menu, Press 9.
    """
    repeatDelay: 5000
    actions:
      "9": "start"
  start:
    text: """
      You have reached to remote terminal access service for Corporation 4 5 2.
      Press 1, for General Enquiries.
      Press 2, to access services relating to our remote terminal products.
      Press 3, for more information regarding any of our other products.
      For HR related queries please press 7.
      To return to the main menu, Press 9.
    """
    repeatDelay: 3000
    actions:
      "1": "general"
      "2": "terminalproducts"
      "3": "products"
      "7": "hr"
      "9": "start"

  general: 
    text: """
      This remote terminal service is provided as described in the R T 0 2 3 Field Handlers Manual page 7. 
      Press 1 if you do not have a Field Handlers Manual for this device.
      Press 2 to register a Remote Termial device.
      Press 5 If you'd like to be transfered to our contracted Customer Support service.
      To return to the main menu, Press 9.
    """
    repeatDelay: 3000
    actions:
      "1": "nomanual"
      "2": "registerterminal"
      "5": "customersupport"
      "9": "start"

  nomanual:
    text: """
      The Field handlers Manual for this  R T 0 2 3 remote terminal device should have been provided to you during the induction phase of your field training.
      If you have misplaced you're Manual please Press 1.
      If you never completed field training or were not provided with a manual during this process please press 2.
      If this terminal's manual has been destroyed as part of S O P, 4. F. 3., please press 3.
      If you are following S O P, 3 0 1, please proceed by keying in the serial number of this device followed by the hash key.
      To return to the main menu, Press 9.
    """
    repeatDelay: 3000
    actions:
      "1": "lostmanual"
      "2": "notraining"
      "3": "manualdestroyed"
      "00000": "sop301"
      "9": "start"

  registerterminal: 
    text: """
       Before proceding with the device registration procedure A as descibed on Page 12 of the Field Handlers Manual. You are required to confirm the following
       Press 1 if this device has not previously been registered.
       Press 2 if this is not the first device to be registered to your Field Handler Identification Factor.
       If you have the previously registered Field handlers Identification Factor ready to be entered, Press 4.
       To return to the main menu, Press 9.
    """
    repeatDelay: 3000
    actions:
      "1": "notregistered"
      "2": "nthdevice"
      "4": "previousidfactor"
      "9": "start"

  customersupport:
    text: """
      Please hold... ... one of our operators will be with you shortly.
    """ 
    repeatDelay: 5000
    actions:
      "9": "start"

  hr:
    text: """
      Please hold...  ... one of our operators will be with you shortly.
    """ 
    repeatDelay: 5000
    actions:
      "9": "start"

  terminalproducts:
    text: """
      To recieve a full catalogue of terminal products press 1.
      If you are trying to register a terminal product press 2
    """
    repeatDelay: 3000
    actions:
      "1": "fullcatalogue"
      "2": "registerterminal"

  fullcatalogue:
    text: """
      The Full catalogue contains a total of 45 products...
      For Products starting with letters A. through E., press 1.
      For Products starting with letters F. through J., press 2.
      For Products starting with letters K. through O., press 4.
      Blah
      Blah
      Blah
      To return to the main menu, Press 9.
    """
    repeatDelay: 3000
    actions:
      "9": "start"

  products:
    text: """
      The Full catalogue contains a total of 45 products...
      For Products starting with letters A. through E., press 1.
      For Products starting with letters F. through J., press 2.
      For Products starting with letters K. through O., press 4.
      Blah
      Blah
      Blah
      To return to the main menu, Press 9.
    """
    repeatDelay: 3000
    actions:
      "9": "start"



