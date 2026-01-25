# Biomedical Robotics - Assignment 1 - ex 2  
#### Group 09 
- Elisa Martinenghi, 6504193  
- Roberto Bertelli, 7289118  
- Mattia Tinfena, 7852527

#### Question 4
Can you think about a different way to map the muscles and be able to reach all 8 targets with the activation of these muscles?  
Explore an alternative mapping approach between muscles and cursor movement that 
enables reaching all 8 targets. Identify any potential drawbacks associated with this alternative mapping 
method.

#### Answer 4
In our implementation, we use a direct mapping, where each muscle controls a single axis.  
A possible alternative mapping approach could consist in using a Linear Regression Matrix M.  
In this case, the cursor velocity could be calculated as
$v = M \times emg\_sign$, where $emg\_sign$ is a vector containing the 4 muscle activations.  
The matrix M is used to couple the EMG input signals, achieving an output signal that depends on each muscle activation. The size of M would be [2x4], since we want to control both x and y using 4 input channels.     
An example of the output could be:  

$$c_x = m_{1,1} \times s1_{x} + m_{1,2} \times s2_{x} + m{1,3} \times s3_{x} + m_{1,4} \times s4_{x}$$
$$c_y = m_{2,1} \times s1_{y} + m_{2,2} \times s2_{y} + m{2,3} \times s3_{y} + m_{2,4} \times s4_{y}$$

where $s1, s2, s3, s4$ are the EMG signals

With this kind of implementation, all 8 targets can be reached through "muscle synergies"—coordinated activations of multiple muscles.  

Possible drawbacks:  
- In the matrix M are contained some weights, which are used to choose how important a signal is wrt the others.  
This requires a setup phase to determine the weights of the matrix for each specific user, making the system less flexible.  
- The cursor could drift if adjacent muscles are involuntary activated.

\newpage

#### Question 5
Can you think of a different way to map the EMG activity to control of the cursor? There is no need for 
implementation, just answer the question, motivating your answer.

#### Answer 5
During this assignment we used the EMG signals as a direct input to control the cursor.  
An alternative to this approach could be represented by mapping the movement of the cursor to the derivative of the EMG signal, which correspond to the velocity of the muscles activation.  
This mapping method could be useful for a different type of patient, since the rehabilitation would be more focused on the velocity of the movement rather than the activation of the muscle.
