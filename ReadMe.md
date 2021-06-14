## Enigma

This is the repo for Taylor Varoglu's BE Mod1 **Enigma** project.


### [Project Requirements:](https://backend.turing.edu/module1/projects/enigma/requirements)

[Encryption Algorithm](https://backend.turing.edu/module1/projects/enigma/encryption)

[Evaluation Rubric](https://backend.turing.edu/module1/projects/enigma/rubric)



### Self Assessment:

```ruby
    def assessment(self)
      {
        4 => 'Above Expectations',
        3 => 'Meets Expectations',
        2 => 'Below Expectations',
        1 => 'Well Below Expectations'
      }
```

**Functionality: 4**
    - Cracking method and CLI successfully tested and implemented.

**Object Oriented Programming: 3**
    - Project is broken down into logical components that are appropriately encapsulated. No classes are unreasonably small or large, or contain knowledge/information/behavior that they shouldn't know about. Student can articulate the single responsibilities of the various components.
    - Original idea for runner files was to create `Encrypt` and `Decrypt` classes, which would `inherit` from the `FileHandler` class for script executions. This design proved to be more cumbersome and complicated just for the sake of complication, which led to the decision to keep all file handling responsibilities within the `FileHandler` class methods.
    - The `FileHandler` class methods ultimately function very similarly to how a `module` would, but are not defined explicitly as such.

**Ruby Conventions and Mechanics: 4**
    - Classes, methods, and variables are well named so that they clearly communicate their purpose. Code is all properly indented and syntax is consistent. No methods are longer than 10 lines. Most enumerables/data structures chosen are the most efficient tool for a given job, and students can speak as to why those enumerables/data structures were chosen.

**Test Driven Development: 3.9999**
    - Stubs are used appropriately to ensure testing is more robust (i.e, testing methods that might not otherwise be tested due to factors like randomness or user input), testing is more efficient, and that classes can be tested without relying on functionality from other classes. Student is able to speak as to how stubs are fulfilling the above conditions.
    - Test coverage metrics show **99.3%** coverage:
        - The `retrieve_message` method in the `FileHandler` class collects user input (writing a message to the `message.txt` file via `gets.chomp`, for the `encrypt.rb` runner file to execute against) is stubbed, which pulls the coverage report below 100%, due to the two lines within the method being omitted due to the stub (one that prints a prompt, the other that collects the user's input).
        - Given that the method call (the actual writing of the message) is tested during the CLI encryption/decryption process, coverage could arguably be considered 100%.
        - Leaving this method unstubbed (to force 100% coverage) prints the prompt during RSpec runs, which is unconventional, and practicing stubs with a marginally sub-100% coverage was deemed a more beneficial learning exercise.
        - Screenshots below to capture testing outputs and paradox previously described:





<img width="592" alt="test_output_all.png" src="https://user-images.githubusercontent.com/58891447/121927233-099c5f80-ccfc-11eb-847f-40a8bf01d26b.png">

<img width="400" alt="test_output_filehandler.png" src="https://user-images.githubusercontent.com/58891447/121927409-3cdeee80-ccfc-11eb-92e6-f3f936fffb00.png">
