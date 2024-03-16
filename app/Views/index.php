<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UBAM</title>
    <style>
        .container {
            /* Basic dimensions and centering */
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;

            /* Dark mode colors and gradient */
            background: #121212;
            /* Fallback for browsers that don't support gradients */
            background: linear-gradient(135deg,
                    #121212 25%,
                    #1a1a1a 25%,
                    #1a1a1a 50%,
                    #121212 50%,
                    #121212 75%,
                    #1a1a1a 75%,
                    #1a1a1a);
            background-size: 40px 40px;

            /* Animation */
            animation: move 4s linear infinite;
        }

        @keyframes move {
            0% {
                background-position: 0 0;
            }

            100% {
                background-position: 40px 40px;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        
    </div>
</body>

</html>