% Process images named toast_1, toast_2, ..., toast_11
for i = 1:11
    % Reads image
    filename = sprintf('toast_%d.png', i);
    img = imread(filename);

    % Apply the exported segmentation function
    [BW, maskedRGBImage] = createMask(img);

    % Convert the masked RGB image to grayscale
    grayImage = rgb2gray(maskedRGBImage);

    % Pre-process the binary mask
    BW_clean = imopen(BW, strel('disk', 3)); % Removes small noise
    BW_clean = imclose(BW_clean, strel('disk', 5)); % Fills gaps smaller than 5 pizels
    BW_clean = bwareaopen(BW_clean, 50); % Remove connected components smaller than 50 pixels
    BW = BW_clean;

    % Apply edge detection on the Black and White image
    edges = edge(BW, 'Canny');

    % Save binary Mask (BW) and masked RGB Image
    maskFilename = sprintf('toast_mask_%d.jpg', i);
    imwrite(BW, maskFilename); % Save Binary Mask

    processedFilename = sprintf('processed_toast_%d.png', i);
    imwrite(maskedRGBImage, processedFilename); % Save the masked RGB image

    grayFilename = sprintf('gray_toast_%d.png', i);
    imwrite(grayImage, grayFilename); % Save the grayscale image
    
    edgeFilename = sprintf('edged_toast_%d.png', i);
    imwrite(edges, edgeFilename); % Save the edges (binary image)

    % Save the Binary Mask (BW) for later use in Python
    maskDataFilename = sprintf('toast_mask_%d.mat', i);
    save(maskDataFilename, 'BW'); % Save the BW mask

    % Display each step for visualization
    figure;
    subplot(2, 2, 1); imshow(maskedRGBImage); title('Masked RGB Image')
    subplot(2, 2, 2); imshow(grayImage); title('Grayscale Image');
    subplot(2, 2, 3); imshow(edges); title('Edge Detected');
    subplot(2, 2, 4); imshow(BW); title('Binary Mask');
    pause(0.33); % Pause to view each image
end