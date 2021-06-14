## Enigma

This is the repo for Taylor Varoglu's BE Mod1 **Enigma** project.


### [Project Requirements:](https://backend.turing.edu/module1/projects/enigma/requirements)

  - [Encryption Algorithm](https://backend.turing.edu/module1/projects/enigma/encryption)

  - [Evaluation Rubric](https://backend.turing.edu/module1/projects/enigma/rubric)



### Self Assessment:

```ruby
    def assessment(self)
      {
        4 => 'Above Expectations',
        3 => 'Meets Expectations',
        2 => 'Below Expectations',
        1 => 'Well Below Expectations'
      }
    end
    rubric_items.each { |item| puts assessment(item)[4] || puts assessment(item)[3] }
```

**Functionality: 4**

  - Cracking method and CLI successfully tested and implemented.
    - Encryption (can be run with or without key and/or date):

      ```bash
      $ ruby ./lib/encrypt.rb message.txt encrypted.txt 22464

      Please enter a message to encrypt:
       >
      DER KRIEG ENDET HEUTE END
      Created 'encrypted.txt' with the key 22464 and date 150621
      ```

    - Decryption (can be run with or without date):

      ```bash
      $ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 22464
      Created 'decrypted.txt' with the key 22464 and date 150621
      ```

    - Cracking (can be run with or without date):

      ```bash
      $ ruby ./lib/crack.rb encrypted.txt cracked.txt
      Created 'cracked.txt' with the key 22464 and date 150621
      ```


**Object Oriented Programming: 3**

  - Project is broken down into logical components that are appropriately encapsulated. No classes are unreasonably small or large, or contain knowledge/information/behavior that they shouldn't know about. Student can articulate the single responsibilities of the various components.
  - Original idea for runner files was to create `Encrypt` and `Decrypt` classes, which would `inherit` from the `FileHandler` class for script executions. This design proved to be more cumbersome and complicated just for the sake of complication, which led to the decision to keep all file handling responsibilities within the `FileHandler` class methods.
  - The `FileHandler` class methods ultimately function very similarly to how a `module` would, but are not defined explicitly as such.

**Ruby Conventions and Mechanics: 4**

  - Classes, methods, and variables are well named so that they clearly communicate their purpose. Code is all properly indented and syntax is consistent. No methods are longer than 10 lines. Most enumerables/data structures chosen are the most efficient tool for a given job, and student can speak as to why those enumerables/data structures were chosen.

**Test Driven Development: 3.9999**

  - Stubs are used appropriately to ensure testing is more robust (i.e, testing methods that might not otherwise be tested due to factors like randomness or user input), testing is more efficient, and classes can be tested without relying on functionality from other classes. Student is able to speak as to how stubs are fulfilling the above conditions.
  - Test coverage metrics show **99.3%** coverage:
      - The `retrieve_message` method in the `FileHandler` class collects user input (which writes a message to the `message.txt` file via `gets.chomp`, for the `encrypt.rb` runner file to execute against) is stubbed, which pulls the coverage report below 100%, due to the two lines within the method being omitted due to the stub (one that prints a prompt, and the other that collects the user's input).
      - Given that the method call (the actual writing of the message) is tested during the CLI encryption/decryption process, coverage could arguably be considered 100%.
      - Leaving this method unstubbed (to force 100% coverage) prints the prompt during RSpec runs, which is unconventional, and furthermore, practicing stubs with a marginally sub-100% coverage was deemed a more beneficial learning exercise.
      - Screenshots below to capture testing outputs and previously described paradox:


<img width="838" alt="test_output_all.png" src="https://user-images.githubusercontent.com/58891447/121966202-724f0080-cd2b-11eb-8613-04b2b5280944.png">

<img width="774" alt="test_output_filehandler.png" src="https://user-images.githubusercontent.com/58891447/121966266-8e52a200-cd2b-11eb-8ca4-becd421b7db0.png">
