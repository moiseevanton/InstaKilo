//
//  ViewController.m
//  InstaKilo
//
//  Created by Anton Moiseev on 2016-05-18.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCell.h"
#import "Photo.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *organization;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *listOfPhotosBySubject;

@property (strong, nonatomic) NSMutableArray *listOfPhotosByLocation;

@property (strong, nonatomic) NSMutableArray *listOfPhotosUsed;

@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.organization addTarget:self action:@selector(updateView:) forControlEvents:UIControlEventValueChanged];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    self.tap.numberOfTapsRequired = 2;
    [self.collectionView addGestureRecognizer:self.tap];
    
    
    self.listOfPhotosBySubject = [NSMutableArray new];
    NSMutableArray *familyArray = [NSMutableArray new];
    NSMutableArray *friendsArray = [NSMutableArray new];
    
    self.listOfPhotosByLocation = [NSMutableArray new];
    NSMutableArray *torontoArray = [NSMutableArray new];
    NSMutableArray *montrealArray = [NSMutableArray new];
    
    for (int i= 1; i < 11; ++i) {
        
        NSString *photoName = [NSString stringWithFormat:@"photo%d", i];
        
        if ([photoName isEqualToString:@"photo8"] || [photoName isEqualToString:@"photo2"]) {
            
            [familyArray addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:photoName] type:@"family"]];
        }
        else {
            
           [friendsArray addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:photoName] type:@"friends"]];
            
        }
    }
    [self.listOfPhotosBySubject addObject:familyArray];
    [self.listOfPhotosBySubject addObject:friendsArray];
    
    for (int i= 1; i < 11; ++i) {
        
        NSString *photoName = [NSString stringWithFormat:@"photo%d", i];
        
        if ([photoName isEqualToString:@"photo10"] || [photoName isEqualToString:@"photo9"] || [photoName isEqualToString:@"photo3"]) {
            
            [montrealArray addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:photoName] type:@"montreal"]];
        }
        else {
            
            [torontoArray addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:photoName] type:@"toronto"]];
            
        }
    }
    [self.listOfPhotosByLocation addObject:montrealArray];
    [self.listOfPhotosByLocation addObject:torontoArray];
    
    if ([[self.organization titleForSegmentAtIndex:self.organization.selectedSegmentIndex] isEqualToString:@"Subject"]) {
        
        self.listOfPhotosUsed = self.listOfPhotosBySubject;
        
    }
    
    if ([[self.organization titleForSegmentAtIndex:self.organization.selectedSegmentIndex] isEqualToString:@"Location"]) {
        
        self.listOfPhotosUsed = self.listOfPhotosByLocation;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.listOfPhotosUsed.count;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        NSMutableArray *array0 = self.listOfPhotosUsed[section];
        return array0.count;
        
    }
    
    if (section == 1) {
        
        NSMutableArray *array1 = self.listOfPhotosUsed[section];
        return array1.count;
        
    }
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ourCell" forIndexPath:indexPath];
    
    Photo *thePhoto = self.listOfPhotosUsed[indexPath.section][indexPath.item];
    [cell.photoImageView setImage:thePhoto.image];
    [cell.photoImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        
        UILabel *label = [header viewWithTag:1];
        
        if (indexPath.section == 0) {
            
            if ([[self.organization titleForSegmentAtIndex:self.organization.selectedSegmentIndex] isEqualToString:@"Subject"]) {
                
                label.text = @"Family photos";
                
            }
            
            if ([[self.organization titleForSegmentAtIndex:self.organization.selectedSegmentIndex] isEqualToString:@"Location"]) {
                
                label.text = @"Montreal";
                
            }
            
        }
        if (indexPath.section == 1) {
            
            if ([[self.organization titleForSegmentAtIndex:self.organization.selectedSegmentIndex] isEqualToString:@"Subject"]) {
                
                label.text = @"My friends and I";
                
            }
            
            if ([[self.organization titleForSegmentAtIndex:self.organization.selectedSegmentIndex] isEqualToString:@"Location"]) {
                
                label.text = @"Toronto";
                
            }
        
        }
        return header;
    }
    return nil;
}

- (void) updateView:(UISegmentedControl *)sender {
    
    if ([[self.organization titleForSegmentAtIndex:self.organization.selectedSegmentIndex] isEqualToString:@"Subject"]) {
        
        self.listOfPhotosUsed = self.listOfPhotosBySubject;
        
        
    }
    
    if ([[self.organization titleForSegmentAtIndex:self.organization.selectedSegmentIndex] isEqualToString:@"Location"]) {
        
        self.listOfPhotosUsed = self.listOfPhotosByLocation;
        
    }
    
    [self.collectionView reloadData];
    
}

- (void)tapped:(UITapGestureRecognizer *)sender {
    
    NSIndexPath *ip = [self.collectionView indexPathForItemAtPoint:[sender locationInView:self.collectionView]];
    
    NSMutableArray *array = self.listOfPhotosUsed[ip.section];
    [array removeObjectAtIndex:ip.item];
    [self.collectionView reloadData];

}

@end
