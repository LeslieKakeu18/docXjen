pipeline {
    agent any
    
    environment {
        CONTAINER_ID = ''  
        SUM_FILE_PATH = 'C:\\Users\\kakeu\\Downloads\\DOCJEN\\sum.py'  
        DIR_PATH = 'C:\\Users\\kakeu\\Downloads\\DOCJEN'  
        TEST_FILE_PATH = 'C:\\Users\\kakeu\\Downloads\\DOCJEN\\test'  
    }

    stages {
        stage('Initialisation') {
            steps {
                script {
                    echo "Agent défini et variables d'environnement configurées."
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    echo "Construction de l'image Docker..."
                    bat "docker build -t python-sum %DIR_PATH%"
                }
            }
        }

        stage('Run') {
            steps {
                script {
                    echo "Exécution du conteneur Docker..."
                    def output = bat(script: 'docker run -d python-sum', returnStdout: true)
                    def lines = output.split('\n')
                    CONTAINER_ID = lines[-1].trim()
                    echo "Conteneur démarré avec l'ID: ${CONTAINER_ID}"
                }
            }
        }

       stage('Test') {
    steps {
        script {
            echo "Début des tests..."
            
            // Lecture et nettoyage du fichier de test
            def testLines = readFile(TEST_FILE_PATH).trim().split('\n')

            for (line in testLines) {
                def vars = line.split(' ')
                def arg1 = vars[0]
                def arg2 = vars[1]
                def expectedSum = vars[2].toFloat()

                // Vérification des valeurs lues
                echo "Test avec ${arg1} + ${arg2}, somme attendue : ${expectedSum}"

                // Exécution du script dans le conteneur Docker
                def output = bat(script: "docker exec ${CONTAINER_ID} python3 /app/sum.py ${arg1} ${arg2}", returnStdout: true).trim()

                
                // Affichage de la sortie pour débogage
                echo "Sortie brute de sum.py : ${output}"

                // Extraction du dernier élément
                def result = output.split('\n')[-1].trim().toFloat()

                // Vérification du résultat
                if (result == expectedSum) {
                    echo "Test réussi : ${arg1} + ${arg2} = ${result}"
                } else {
                    error "Échec du test : ${arg1} + ${arg2} attendu ${expectedSum} mais obtenu ${result}"
                }
            }
        }
    }
}

}
}
      

        